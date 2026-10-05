data "aws_availability_zones" "available" {

  state = "available"
}

locals {

  vpc_mask = tonumber(split("/", var.vpc_cidr)[1])

  subnet_requests = flatten([

    for tier_name, tier in var.tiers : [

      for i in range(tier.subnet_count) : {

        tier_name = tier_name

        subnet_type = tier.subnet_type

        required_ips = tier.required_ips
      }
    ]
  ])

  subnet_calculations = [

    for subnet in local.subnet_requests : {

      tier_name = subnet.tier_name

      subnet_type = subnet.subnet_type

      required_ips = subnet.required_ips

      total_ips_needed = subnet.required_ips + 5

      host_bits = ceil(
        log(subnet.required_ips + 5, 2)
      )

      subnet_mask = 32 - ceil(
        log(subnet.required_ips + 5, 2)
      )

      newbits = (
        32 - ceil(
          log(subnet.required_ips + 5, 2)
        )
      ) - local.vpc_mask
    }
  ]

  sorted_subnets = [

    for subnet_json in reverse(sort([

      for subnet in local.subnet_calculations :

      jsonencode(subnet)

    ])) :

    jsondecode(subnet_json)
  ]

  subnet_newbits = [

    for subnet in local.sorted_subnets :

    subnet.newbits
  ]

  generated_cidrs = cidrsubnets(
    var.vpc_cidr,
    local.subnet_newbits...
  )

  generated_subnets = [

    for idx, subnet in local.sorted_subnets : {

      subnet_name = "${subnet.tier_name}-${idx + 1}"

      tier_name = subnet.tier_name

      subnet_type = subnet.subnet_type

      required_ips = subnet.required_ips

      subnet_mask = subnet.subnet_mask

      cidr = local.generated_cidrs[idx]

      availability_zone = data.aws_availability_zones.available.names[
        idx % length(data.aws_availability_zones.available.names)
      ]
    }
  ]
}

resource "aws_subnet" "dynamic" {

  for_each = {

    for subnet in local.generated_subnets :

    subnet.subnet_name => subnet
  }

  vpc_id = var.vpc_id

  cidr_block = each.value.cidr

  availability_zone = each.value.availability_zone

  map_public_ip_on_launch = each.value.subnet_type == "public"

  tags = {

    Name = each.value.subnet_name

    Tier = each.value.tier_name

    Type = each.value.subnet_type
  }
}

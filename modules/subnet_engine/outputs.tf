output "generated_subnets" {

  value = local.generated_subnets
}

output "public_subnets" {

  value = {

    for k, subnet in aws_subnet.dynamic :

    k => subnet.id

    if subnet.map_public_ip_on_launch == true
  }
}

output "private_subnets" {

  value = {

    for k, subnet in aws_subnet.dynamic :

    k => subnet.id

    if subnet.map_public_ip_on_launch == false
  }
}

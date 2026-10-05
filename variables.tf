variable "vpc_cidr" {

  type = string
}


variable "tiers" {

  type = map(object({

    subnet_count = number

    subnet_type = string

    required_ips = number

    security_rules = list(object({

      from_port = number

      to_port = number

      protocol = string

      cidr_blocks = optional(list(string))

      source_tier = optional(string)
    }))
  }))
}

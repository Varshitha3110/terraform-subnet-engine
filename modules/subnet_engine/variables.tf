variable "vpc_id" {

  type = string
}

variable "vpc_cidr" {

  type = string
}

variable "tiers" {

  type = map(object({

    subnet_count = number

    subnet_type = string

    required_ips = number
  }))
}

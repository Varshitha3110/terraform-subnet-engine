vpc_cidr = "10.0.0.0/16"

tiers = {

  frontend = {
    subnet_count = 2
    subnet_type  = "public"
    required_ips = 40
    security_rules = [

      {
        from_port = 80
        to_port   = 80
        protocol  = "tcp"

        cidr_blocks = ["0.0.0.0/0"]
      },

      {
        from_port = 443
        to_port   = 443
        protocol  = "tcp"

        cidr_blocks = ["0.0.0.0/0"]
      },

      {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"

        cidr_blocks = ["122.171.20.156/32"]
      }
    ]
  }

  application = {
    subnet_count = 2
    subnet_type  = "private"
    required_ips = 60
    security_rules = [

      {
        from_port = 8080
        to_port   = 8080
        protocol  = "tcp"

        source_tier = "frontend"
      }
    ]
  }

  database = {

    subnet_count = 2
    subnet_type  = "private"
    required_ips = 60
    security_rules = [

      {
        from_port = 3306
        to_port   = 3306
        protocol  = "tcp"

        source_tier = "application"
      }
    ]
  }
}
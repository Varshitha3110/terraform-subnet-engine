#################################################
# DYNAMIC SECURITY GROUPS
#################################################

resource "aws_security_group" "tier_sg" {

  for_each = var.tiers

  name = "${each.key}-sg"
  description = "Security Group for ${each.key}"

  vpc_id = var.vpc_id

  #################################################
  # DEFAULT EGRESS
  #################################################

  egress {

    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {

    Name = "${each.key}-sg"

    Tier = each.key
  }
}

#################################################
# BUILD ALL INGRESS RULES
#################################################

locals {

  ingress_rules = flatten([

    for tier_name, tier in var.tiers : [

      for rule in tier.security_rules : {

        rule_key = "${tier_name}-${rule.from_port}-${rule.to_port}"

        target_tier = tier_name

        from_port = rule.from_port

        to_port = rule.to_port

        protocol = rule.protocol

        cidr_blocks = try(rule.cidr_blocks, null)

        source_tier = try(rule.source_tier, null)
      }
    ]
  ])
}

#################################################
# CIDR BASED RULES
#################################################

resource "aws_security_group_rule" "cidr_rules" {

  for_each = {

    for rule in local.ingress_rules :

    rule.rule_key => rule

    if rule.cidr_blocks != null
  }

  type = "ingress"

  from_port = each.value.from_port

  to_port = each.value.to_port

  protocol = each.value.protocol

  cidr_blocks = each.value.cidr_blocks

  security_group_id = aws_security_group.tier_sg[
    each.value.target_tier
  ].id
}

#################################################
# SECURITY GROUP BASED RULES
#################################################

resource "aws_security_group_rule" "sg_rules" {

  for_each = {

    for rule in local.ingress_rules :

    rule.rule_key => rule

    if rule.source_tier != null
  }

  type = "ingress"

  from_port = each.value.from_port

  to_port = each.value.to_port

  protocol = each.value.protocol

  security_group_id = aws_security_group.tier_sg[
    each.value.target_tier
  ].id

  source_security_group_id = aws_security_group.tier_sg[
    each.value.source_tier
  ].id
}

resource "aws_internet_gateway" "igw" {

  vpc_id = var.vpc_id
  tags = {
    Name = "dynamic-igw"
  }
}

resource "aws_route_table" "public" {

  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_assoc" {

  for_each       = var.public_subnets
  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

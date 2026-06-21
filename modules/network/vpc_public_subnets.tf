resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[count.index].cidr
  availability_zone       = var.public_subnets[count.index].availability_zone
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name                     = var.public_subnets[count.index].name,
      "kubernetes.io/role/elb" = 1
    }
  )

}

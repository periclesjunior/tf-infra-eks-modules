resource "aws_subnet" "eks_public_subnet_1a" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 1)
  availability_zone       = "${data.aws_region.current.region}a"
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name                     = "${var.project_name}-pub-subnet-1a",
      "kubernetes.io/role/elb" = 1
    }
  )
}

resource "aws_subnet" "eks_public_subnet_1b" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 2)
  availability_zone       = "${data.aws_region.current.region}b"
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name                     = "${var.project_name}-pub-subnet-1b",
      "kubernetes.io/role/elb" = 1
    }
  )
}

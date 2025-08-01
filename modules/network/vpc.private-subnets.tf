resource "aws_subnet" "eks_private_subnet_1a" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 3)
  availability_zone = "${data.aws_region.current.region}a"

  tags = merge(
    var.tags,
    {
      Name                              = "${var.project_name}-priv-subnet-1a",
      "kubernetes.io/role/internal-elb" = 1
    }
  )
}

resource "aws_subnet" "eks_private_subnet_1b" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 4)
  availability_zone = "${data.aws_region.current.region}b"

  tags = merge(
    var.tags,
    {
      Name                              = "${var.project_name}-priv-subnet-1b",
      "kubernetes.io/role/internal-elb" = 1
    }
  )
}

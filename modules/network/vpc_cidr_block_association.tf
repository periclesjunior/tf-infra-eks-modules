resource "aws_vpc_ipv4_cidr_block_association" "main" {
  count = length(var.vpc_additional_cidrs)

  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = var.vpc_additional_cidrs[count.index]
}

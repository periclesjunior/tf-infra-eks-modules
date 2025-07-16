resource "aws_nat_gateway" "eks_ngw_1a" {
  allocation_id = aws_eip.eks_ngw_eip_1a.id
  subnet_id     = aws_subnet.eks_public_subnet_1a.id

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-ngw-1a"
    }
  )
}

resource "aws_nat_gateway" "eks_ngw_1b" {
  allocation_id = aws_eip.eks_ngw_eip_1b.id
  subnet_id     = aws_subnet.eks_public_subnet_1b.id

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-ngw-1b"
    }
  )
}

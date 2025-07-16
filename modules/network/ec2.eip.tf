resource "aws_eip" "eks_ngw_eip_1a" {
  domain   = "vpc"
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-eip-1a"
    }
  )
}

resource "aws_eip" "eks_ngw_eip_1b" {
  domain   = "vpc"
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-eip-1b"
    }
  )
}

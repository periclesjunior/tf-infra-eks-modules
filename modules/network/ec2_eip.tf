resource "aws_eip" "nat" {
  count = length(var.public_subnets)

  domain = "vpc"

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-eip-natgw-${count.index}"
    }
  )
}

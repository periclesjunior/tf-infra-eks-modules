resource "aws_route_table" "private" {
  count = length(var.private_subnets)

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[
      count.index % length(aws_nat_gateway.main)
    ].id
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-private-rt-${count.index}"
    }
  )
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

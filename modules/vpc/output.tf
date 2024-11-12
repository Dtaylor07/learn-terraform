output "vpc-id" {
  value = aws_vpc.main.id
}

output "subnet-id" {
  value = aws_subnet.main.id
}

output "route-table-id" {
  value = aws_route_table.main.id
}
output "instance-id" {
  value = aws_instance.main.id
}

output "public-ip" {
  value = aws_instance.main.public_ip
}

output "instance-arn" {
  value = aws_instance.main.arn
}

output "tenancy" {
  value = aws_instance.main.tenancy
}
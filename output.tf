output "vpc-id" {
  value = module.vpc.vpc-id
}

output "instance-id" {
  value = module.webserver.instance-id
}

output "public-ip" {
  value = module.webserver.public-ip
}

output "instance-arn" {
  value = module.webserver.instance-arn
}

output "tenancy" {
  value = module.webserver.tenancy
}
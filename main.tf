module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block    = "10.7.17.0/24"
  subnet_cidr_block = "10.7.17.48/28"
  subnet_type       = "public"
  route-table-name  = "public-RT"
  igw-name          = "my-igw"
  vpc-name          = "vpc-module"

}

module "webserver" {
  source = "./modules/ec2"

  associate_public_ip_address = true
  key_name                    = "aws_key"
}



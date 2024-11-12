resource "aws_instance" "main" {
  instance_type               = var.instance_type
  ami                         = var.ami
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = aws_key_pair.main.key_name
}

resource "aws_key_pair" "main" {
  key_name   = var.key_name
  public_key = var.public_key
}

data "aws_vpc" "default-vpc" {
  default = true
}

resource "aws_security_group" "test-sg-web" {
  description = "test security group"
  name        = "allow https"
  vpc_id      = data.aws_vpc.default-vpc.id

  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = "ssh-allowed"
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    },
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = "http-allowed"
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 80
    }
  ]

}

resource "aws_instance" "webserver" {
  ami                    = "ami-063d43db0594b521b"
  instance_type          = "t2.micro"
  key_name               = "aws_key"
  vpc_security_group_ids = [aws_security_group.test-sg-web.id]

  provisioner "file" {
    source      = "C:/file/provisioner.txt"
    destination = "/home/ec2-user/provisioner.txt"
  }

  // You need to recreate the instance in order to remote-exec to work. It is a user script that runs during instance initialization.

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "echo 'Hello there. You are in' | sudo tee /var/www/html/index.html > /dev/null"
    ]
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("C:/keys/aws_key")
    timeout     = "5m"
  }
}


// local-exec - To run script on local machine.
resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "echo $VAR1 $VAR2 $VAR3 >> my_vars.txt"

    environment = {
      VAR1 = "my-value-1"
      VAR2 = "my-value-2"
      VAR3 = "my-value-3"
    }
  }
}

// Generate key pair using any terminal use command "ssh-keygen -t rsa -b 2048"

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtpry0iqa6AncyIL9XJLW8VnoJ3D+z9XSsdfAAjWJAO+Bjw5eMraJwI3aE2xEH8Lh7nYxE1YVFUxmpEST1Km7xDxTFeIdVcwCejLGQ7HJy+cNp+URAqCYY8lOHNmH6QOuwBEuSen7LJqEL0uTlMvXCTb3yTieBr/B5TskSTi2tqzsl9xWm9RyYu6YO/Ll1vFNFGDlLuFwrq4O6hUiZWOOhZlhnBjzc/HFmum6jzQcFI2+vNtf5glDJr8bz9QTBkZdUKo6m99w3v08OeShSnQ0vRei3qzJZOHZhJDkv9jUbT7OA08jn5WLR+0GYXAc34OcaeRkTZsGeN1amoGjybexx dhava@DESKTOP-PNGSLM7"
}

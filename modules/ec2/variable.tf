variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami" {
  type    = string
  default = "ami-063d43db0594b521b"
}

variable "associate_public_ip_address" {
  type = bool
}

variable "key_name" {
  type = string
}

variable "public_key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtpry0iqa6AncyIL9XJLW8VnoJ3D+z9XSsdfAAjWJAO+Bjw5eMraJwI3aE2xEH8Lh7nYxE1YVFUxmpEST1Km7xDxTFeIdVcwCejLGQ7HJy+cNp+URAqCYY8lOHNmH6QOuwBEuSen7LJqEL0uTlMvXCTb3yTieBr/B5TskSTi2tqzsl9xWm9RyYu6YO/Ll1vFNFGDlLuFwrq4O6hUiZWOOhZlhnBjzc/HFmum6jzQcFI2+vNtf5glDJr8bz9QTBkZdUKo6m99w3v08OeShSnQ0vRei3qzJZOHZhJDkv9jUbT7OA08jn5WLR+0GYXAc34OcaeRkTZsGeN1amoGjybexx dhava@DESKTOP-PNGSLM7"
}
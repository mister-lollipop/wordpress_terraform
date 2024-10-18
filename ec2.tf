provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "wordpress" {
  ami           = "ami-0a5c3558529277641"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  user_data = file("data.sh")
  key_name = "veera"
  vpc_security_group_ids= [aws_security_group.allow_ssh_http_new_one.id]
  tags = {
    Name = "wordpress" 
  }
}
# Security group to allow SSH and HTTP access
resource "aws_security_group" "allow_ssh_http_new" {
  name        = "allow_ssh_http_new_one"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

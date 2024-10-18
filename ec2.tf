provider "aws" {
  region = "us-west-1"
}
resource "aws_instance" "wordpress3" {
  ami           = "ami-0175bdd48fdb0973b"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  user_data = file("data.sh")
  key_name = "keypair"
  vpc_security_group_ids= [aws_security_group.group2.id]
  tags = {
    Name = "wordpress3" 
  }
}
# Security group to allow SSH and HTTP access
resource "aws_security_group" "group2" {
  name        = "group2"
  
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

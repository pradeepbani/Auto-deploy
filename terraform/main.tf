provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "demo_sg" {
  name = "devops-demo-sg"

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

resource "aws_instance" "demo" {
  ami           = "ami-0c3389a4fa5bddaad"
  instance_type = "t2.micro"
  key_name = "devops-key-new"
  vpc_security_group_ids = [aws_security_group.demo_sg.id]

  tags = {
    Name = "devops-demo-server"
  }
}

output "public_ip" {
  value = aws_instance.demo.public_ip
}
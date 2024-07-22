provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "webserver" {
  ami           = var.ami_id
  instance_type = var.instance_type
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"  
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.main.id  
  cidr_block = "10.0.1.0/24"  
}

resource "aws_security_group" "ecs_tasks_sg" {
  name        = "ecs_tasks_sg"  
  description = "Allow inbound traffic for ECS tasks"
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

resource "aws_ecs_cluster" "cluster" {
  name = "nodejs-app-cluster"  
}

#Basic EC2 creation template
=================

provider "aws"{
    region = "us-east-1"
	access_key = "key"
	secret_key = "key"
	}
resource "aws_instance" "web-1"{
    ami = "ami-id"
	instance_type = "t2.micro"
	tags = {
	  Name = "web-1"
	  }

  }
  
  
To Create Multiple instances :
===============

1)  Using count: “If I need multiple identical resources, I use the count argument to specify how many copies Terraform should create.”


provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0c55b159cbfafe1f0"  # Example Amazon Linux AMI
  instance_type = "t2.micro"
  count         = 3   # 👈 Creates 3 instances

  tags = {
    Name = "MyEC2-${count.index + 1}"  # Names: MyEC2-1, MyEC2-2, MyEC2-3
  }
}

2)Using for_each: “If I need multiple resources with different settings, I use for_each so I can assign unique values to each resource.”


provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_ec2" {
  ami           = each.value.ami
  instance_type = each.value.type
  for_each = {
    server1 = { ami = "ami-0c55b159cbfafe1f0", type = "t2.micro" }
    server2 = { ami = "ami-0c55b159cbfafe1f0", type = "t2.small" }
    server3 = { ami = "ami-0c55b159cbfafe1f0", type = "t2.medium" }
  }

  tags = {
    Name = each.key
  }
}



EC2 Instance with Security Group
=======================

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "my_sg" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
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

  tags = {
    Name = "MySecurityGroup"
  }
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (update as per region)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]

  tags = {
    Name = "MyEC2Instance"
  }
}


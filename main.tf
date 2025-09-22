# VPC
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "wordpress-vpc"
  }
}

# subnets
resource "aws_subnet" "public-subnet-a" {
  vpc_id     = "vpc-03a229ed652f8cfbc"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "wordpress-subnet-pub"
  }
}

resource "aws_subnet" "private-subnet-a" {
    vpc_id = "vpc-03a229ed652f8cfbc"
    cidr_block = "10.0.2.0/24"

    tags = {
    Name = "wordpress-subnet-pvt"
  }
  
}

# Internet gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = "vpc-03a229ed652f8cfbc"

  tags = {
    Name = "wordpress-igw"
  }
}

# NAT gateway

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = "eipalloc-02ba1907711c0f521"
  subnet_id = "subnet-084b515812c843d1e"

  tags = {
    Name = "wordpress-nat-gtw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

# ec2 instance

locals {
    userdata_file = "${path.module}/user_data.yaml"
}

resource "aws_instance" "wordpress_ec2" {
    ami = "ami-046c2381f11878233"
    instance_type = "t2.micro"

    user_data = file(local.userdata_file)

    tags = {
        Name = "wordpress-server"

  }
}

resource "aws_security_group" "wordpress_sg" {
    name = "wordpress-sg"
    description = "wordpress-sg created 2025-09-17T15:34:57.109Z"

     egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

   ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

   ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

}


resource "aws_route_table" "pvt_rtb" {
    vpc_id = "vpc-03a229ed652f8cfbc"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "nat-060470cdcf3c4c021"
    }

    tags = {
      Name = "wordpress-pvt-rtb"
    }
}

resource "aws_route_table" "pub_rtb" {
    vpc_id = "vpc-03a229ed652f8cfbc"


    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "igw-091d396bd25ceced5"
    }

    tags = {
      Name = "wordpress-pub-rtb"
    }
}
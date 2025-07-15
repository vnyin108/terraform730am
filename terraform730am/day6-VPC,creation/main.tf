#vpc
resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name = "test"
    }
  
}

#subnet

resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
tags = {
  name = "testsubnet"
}
}

#IG 

resource "aws_internet_gateway" "name" {
    tags = {
      name = "IG"
    }
    vpc_id = aws_vpc.name.id
  
}

#routetable

resource "aws_route_table" "name" {
vpc_id = aws_vpc.name.id
route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
}
}

resource "aws_route_table_association" "name" {
  subnet_id = aws_subnet.name.id
  route_table_id = aws_route_table.name.id
}

#sg

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  vpc_id      = aws_vpc.name.id
  tags = {
    Name = "dev_sg"
  }
 ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
}
ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" #all protocols 
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
}

#ec2
resource "aws_instance" "name" {
    ami = "ami-05ffe3c48a9991133"
    instance_type = "t2.micro"
    key_name = "testdevprod"
    subnet_id = aws_subnet.name.id
    vpc_security_group_ids = [ aws_security_group.allow_tls.id ]

}

#natgateway 

resource "aws_nat_gateway" "name"{
    subnet_id = aws_subnet.name.id
    allocation_id = aws_eip.name.id
    
    tags = {
      Name = "natgate"
    }
  
}
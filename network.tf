locals {
    prd_prefix = "prd"
    dev_prefix = "dev"
} 

#import non terraform service or resource
#in this case defaulty oob vpc
data "aws_vpc" "default-vpc"{
    id = "vpc-1c1c1966"
    tags = {
        Name = "default"
    }
}

output "default-vpc"{
    value = data.aws_vpc.default-vpc.cidr_block
}

variable "subnet_prd_a_prefix" {
    description = "Lorem ipsum dolor sit amet"
    type = string
}

resource "aws_vpc" "vpc-prd"{
    cidr_block = "10.0.0.0/16"
    
    tags = {
        Name = "vpc-${local.prd_prefix}"
    }
}

resource "aws_subnet" "subnet-prd-a"{
    vpc_id = aws_vpc.vpc-prd.id
    cidr_block = var.subnet_prd_a_prefix
    availability_zone =  "us-east-1a"

    tags = {
        Name = "subnet-${local.prd_prefix}-a" 
    }
}

resource "aws_subnet" "subnet-dev-a"{
    vpc_id = aws_vpc.vpc-prd.id
    cidr_block = "10.0.2.0/24"
    availability_zone =  "us-east-1a"

    tags = {
        Name = "subnet-${local.dev_prefix}-a" 
    }
}

resource "aws_internet_gateway" "gw-prd"{
    vpc_id = aws_vpc.vpc-prd.id

    tags = {
        Name = "gw-${local.prd_prefix}" 
    }
}

resource "aws_route_table" "rt-prd"{
    vpc_id = aws_vpc.vpc-prd.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw-prd.id
    }

    route {
        ipv6_cidr_block = "::/0"
        gateway_id =  aws_internet_gateway.gw-prd.id
    }

    tags = {
        Name = "rt-${local.prd_prefix}" 
    }
}

resource "aws_route_table_association" "rta-prd-a" {
    subnet_id = aws_subnet.subnet-prd-a.id
    route_table_id = aws_route_table.rt-prd.id
}

resource "aws_route_table_association" "rta-dev-a" {
    subnet_id = aws_subnet.subnet-dev-a.id
    route_table_id = aws_route_table.rt-prd.id
}
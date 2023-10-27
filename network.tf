resource "aws_network_interface" "ansible_nic"{
    subnet_id = aws_subnet.subnet_prd_a.id
    private_ips = ["10.0.1.20"]
    security_groups = [aws_security_group.allow_ssh_web["vpc_prv"].id]
}

resource "aws_eip" "ansible_ip"{
    network_interface = aws_network_interface.ansible_nic.id
    associate_with_private_ip = "10.0.1.20"
    depends_on = [aws_internet_gateway.gw_prd]
}
#import non terraform service or resource
#in this case defaulty oob vpc
data "aws_vpc" "default_vpc"{
    id = "vpc-1c1c1966"
    tags = {
        Name = "default"
    }
}


resource "aws_vpc" "vpc_prd"{
    cidr_block = "10.0.0.0/16"
    
    tags = {
        Name = "vpc-${local.prd_prefix}"
    }
}

resource "aws_subnet" "subnet_prd_a"{
    vpc_id = aws_vpc.vpc_prd.id
    cidr_block = var.subnet_prd_a_prefix
    availability_zone =  "us-east-1a"

    tags = {
        Name = "subnet-${local.prd_prefix}-a" 
    }
}

resource "aws_subnet" "subnet_dev_a"{
    vpc_id = aws_vpc.vpc_prd.id
    cidr_block = "10.0.2.0/24"
    availability_zone =  "us-east-1a"

    tags = {
        Name = "subnet-${local.dev_prefix}-a" 
    }
}

resource "aws_internet_gateway" "gw_prd"{
    vpc_id = aws_vpc.vpc_prd.id

    tags = {
        Name = "gw-${local.prd_prefix}" 
    }
}

resource "aws_route_table" "rt_prd"{
    vpc_id = aws_vpc.vpc_prd.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw_prd.id
    }

    route {
        ipv6_cidr_block = "::/0"
        gateway_id =  aws_internet_gateway.gw_prd.id
    }

    tags = {
        Name = "rt-${local.prd_prefix}" 
    }
}

resource "aws_route_table_association" "rta_prd_a" {
    subnet_id = aws_subnet.subnet_prd_a.id
    route_table_id = aws_route_table.rt_prd.id
}

resource "aws_route_table_association" "rta_dev_a" {
    subnet_id = aws_subnet.subnet_dev_a.id
    route_table_id = aws_route_table.rt_prd.id
}

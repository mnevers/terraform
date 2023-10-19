provider "aws"{
    region = "us-east-1"
}

#Main not so used. check out Network.tf and others

resource "aws_security_group" "allow-ssh-web"{
    name = "allow-ssh-web-traffic"
    description = "Allow inbound traffic"
    vpc_id = aws_vpc.vpc-prd.id

    ingress {
        description = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["73.69.109.181/32"]
    }

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["73.69.109.181/32"]
    }

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["73.69.109.181/32"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}


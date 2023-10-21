provider "aws"{
    region = "us-east-1"
}

provider "aws"{
    alias = "west"
    region = "us-west-2"
}

locals {
    ingress_rules = [{
        description = "HTTPS"
        from_port = 443
        to_port = 443
    },
    {
        description = "HTTP"
        from_port = 80
        to_port = 80
    },
    {        
        description = "SSH"
        from_port = 22
        to_port = 22
    }]
}

locals {
    my_ip = ["73.69.109.181/32"]
}

resource "aws_security_group" "allow-ssh-web"{
    for_each = {
        vpc_prv = aws_vpc.vpc-prd.id
        vpc_pub = data.aws_vpc.default-vpc.id
    }

    name = "allow-ssh-web-traffic"
    description = "Allow inbound traffic"
    vpc_id = each.value

    dynamic "ingress" {
        for_each = local.ingress_rules

        content {
            description = ingress.value.description
            from_port = ingress.value.from_port
            to_port = ingress.value.to_port
            protocol = "tcp"
            cidr_blocks = local.my_ip
        }
    }
   
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "allow-ssh-web-traffic"
    }
}

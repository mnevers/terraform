provider "aws"{
    region = "us-east-1"
}

provider "aws"{
    alias = "west"
    region = "us-west-2"
}

module "webserver" {
    source = "../modules/webserver"
    vpc_id = "vpc-1c1c1966"
    cidr_block = "10.0.10.0/16"
    webserver_name = "Matt Webserver"
    key_name = "main_key"
    ami = "ami-0fc5d935ebf8bc3bc"
    my_ip = var.my_ip
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
            cidr_blocks = [var.my_ip]
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

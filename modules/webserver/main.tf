terraform {
    required_version = ">= 1.6.2"
}

resource "aws_subnet" "webserver_net"{
    vpc_id = var.vpc_id
    cidr_block = var.cidr_block
}

resource "aws_instance" "ansible-managed"{
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = aws_subnet.webserver_net
    key_name = var.key_name

    tags = {
        Name = var.webserver_name
    }
}

resource "aws_security_group" "allow-ssh-web"{  
    name = "allow-ssh-web-traffic"
    description = "Allow inbound traffic"
    vpc_id = var.vpc_id

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

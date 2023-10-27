provider "aws"{
    region = "us-east-1"
}

provider "aws"{
    alias = "west"
    region = "us-west-2"
}
/*
module "matt_webserver" {
    source = "./modules/webserver"
    subnet_id = var.subnet_id    
    vpc_id = var.vpc_id
    my_ip = var.my_ip    
    key_name = var.key_name
    cidr_block = "172.31.20.0/20"
    webserver_name = "Matt Web Server"
    ami = "ami-0fc5d935ebf8bc3bc"
}*/

resource "aws_security_group" "allow_ssh_web"{
    for_each = {
        vpc_prv = aws_vpc.vpc_prd.id
        vpc_pub = data.aws_vpc.default_vpc.id
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
            protocol = ingress.value.protocol
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

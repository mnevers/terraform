terraform {
    required_version = ">= 1.6.2"
}

resource "aws_instance" "webserver"{
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    key_name = var.key_name
    vpc_security_group_ids = [ aws_security_group.allow-web.id ]

    user_data = <<-EOF
                 #!/bin/bash
                 sudo apt update -y
                 sudo apt install apache2 -y
                 sudo systemctl start apache2
                 sudo bash -c 'echo This is a web server > /var/www/html/index.html'
                 EOF


    tags = {
        Name = var.webserver_name
    }
}

resource "aws_security_group" "allow-web"{  
    name = "allow-web-traffic-${var.webserver_name}"
    description = "Allow inbound traffic for ${var.webserver_name}"
    vpc_id = var.vpc_id

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

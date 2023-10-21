/*resource "aws_instance" "server-lifecycle"{
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t2.micro"

    lifecycle {
        #create_before_destroy = true
        #prevent_destroy = true
    }
}*/

resource "aws_instance" "ansible-managed"{
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t2.micro"
    #subnet_id = aws_subnet.subnet-prd-a.id
    vpc_security_group_ids = [aws_security_group.allow-ssh-web["vpc_pub"].id]
    key_name = "main_key"

    tags = {
        Name = "Prd"
    }

    connection {
        type = "ssh"
        host = self.public_ip
        user = "ubuntu" 
        private_key = file("/home/matt/main_key.pem")
    }

    provisioner "file"{
        content = "test"
        destination = "/home/matt/Projects/terraform/references.txt"
    }
}

output "ansible_ip" {
    value = aws_instance.ansible-managed.public_ip
}

/*
resource "aws_instance" "server-west"{
    ami = "ami-0efcece6bed30fd98"
    instance_type = "t2.micro"
}

resource "aws_instance" "server"{
    for_each = {
        prod = aws_subnet.subnet-prd-a.id
        dev = aws_subnet.subnet-dev-a.id
    }

    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t2.micro"
    subnet_id = each.value

    tags = {
        Name = each.key
    }

    provisioner "local-exec"{
        command = "echo ${self.public_ip} > public-ip.txt"
    }
}

output "private-ips"{
    value = [ for instance in aws_instance.server : instance.private_ip] 
}

output "dev-names"{
    value = [ for instance in aws_instance.server : instance.tags.Name] 
}
*/
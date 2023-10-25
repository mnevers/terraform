/*resource "aws_instance" "server-lifecycle"{
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t2.micro"

    lifecycle {
        #create_before_destroy = true
        #prevent_destroy = true
    }
}*/

resource "aws_instance" "ansible_managed"{
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t2.micro"
    key_name = "main_key"

    network_interface {
        device_index = 0
        network_interface_id = aws_network_interface.ansible_nic.id
    }

    tags = {
        Name = "${terraform.workspace} server"
    }
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

    connection {
        type = "ssh"
        host = self.public_ip
        user = "ubuntu" 
        private_key = file("/path/to/key.pem")
    }

    provisioner "file"{
        content = "test"
        destination = "/home/ubuntu/test.txt"
    }

    provisioner "remove-exec"{
        inline = [
            "touch /home/ubuntu/test.txt"
        ]
    }
}

output "private-ips"{
    value = [ for instance in aws_instance.server : instance.private_ip] 
}

output "dev-names"{
    value = [ for instance in aws_instance.server : instance.tags.Name] 
}
*/
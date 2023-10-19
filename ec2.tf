resource "aws_instance" "server"{
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t2.micro"
    count = 2
    subnet_id = aws_subnet.subnet-dev-a.id    

    tags = {
        Name = "Dev ${count.index}"
    }
}

output "private-ips"{
    value = aws_instance.server[*].private_ip
}

output "dev-names"{
    value = aws_instance.server[*].tags.Name
}
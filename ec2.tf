/*resource "aws_instance" "server-lifecycle"{
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t2.micro"
    subnet_id = each.value

    lifecycle {
        #create_before_destroy = true
        #prevent_destroy = true
    }
}*/

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
}

output "private-ips"{
    value = [ for instance in aws_instance.server : instance.private_ip] 
}

output "dev-names"{
    value = [ for instance in aws_instance.server : instance.tags.Name] 
}
*/
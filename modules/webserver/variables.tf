variable "subnet_id" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "cidr_block"{
    type = string
}

variable "ami"{
    type = string
}

variable "key_name"{
    type = string
}

variable "instance_type"{
    type = string
    default = "t2.micro"
}

variable "webserver_name"{
    type = string
}

variable "my_ip"{
    type = string
    description = "IP to whitelist in security group"
}

locals {
    ingress_rules = [{
        description = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
    },
    {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
    },
    {        
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
    },
    {        
        description = "ICMP"
        from_port = 8
        to_port = 0
        protocol = "icmp"
    }]
}
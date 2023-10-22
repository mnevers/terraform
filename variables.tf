variable "my_ip" {
    type = string
    description = "IP to whitelist in security group"
}

variable "boolean"{
    description = "testing bools"
    type = bool
}

variable "subnet_id"{
    description = "Default VPC subnet ID"
    type = string
}

variable "key_name"{
    description = "Key Name"
    type = string
}

variable "subnet_prd_a_prefix" {
    description = "Lorem ipsum dolor sit amet"
    type = string
}

variable "vpc_id" {
    description = "Default VPC ID"
    type = string
}

locals {
    prd_prefix = "prd"
    dev_prefix = "dev"
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


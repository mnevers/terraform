output "default-vpc"{
    value = var.boolean == true ? data.aws_vpc.default-vpc.cidr_block : "Sensored Message"
}

output "ansible_ip" {
    value = aws_instance.ansible-managed.private_ip
}
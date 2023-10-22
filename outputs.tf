output "default-vpc-out"{
    value = var.boolean == true ? data.aws_vpc.default-vpc.cidr_block : "Sensored Message"
}

output "ansible_ip-out" {
    value = aws_instance.ansible-managed.private_ip
}

#output "webserver_module_ip" {
#  value = module.matt_webserver.webserver_public_ip
#}
output "default_vpc_out"{
    value = var.boolean == true ? data.aws_vpc.default-vpc.cidr_block : "Sensored Message"
    description = "Print out default vpc or if a boolean of yes in a var was given sensor message (if block test)"
}

output "ansible_prv_ip" {
    value = aws_instance.ansible_managed.private_ip
}

output "ansible_pub_ip" {
    value = aws_instance.ansible_managed.public_ip
}

#output "webserver_module_ip" {
#  value = module.matt_webserver.webserver_public_ip
#}
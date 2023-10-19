#rename this file to anything else, i.e example.tfvars 
#and terraform will need a reference in its apply command to know to look for it
#terraform apply -var-file example.tfvars
#this allows for reusable and flexible tf files
subnet_prd_a_prefix = "10.0.1.0/24"
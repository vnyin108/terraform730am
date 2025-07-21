resource "aws_instance" "name" {
 ami = var.ami_id
 instance_type =   var.instance_type
 key_name = var.key
 availability_zone = var.az
 tags = {
   Name = "test"
 }

}
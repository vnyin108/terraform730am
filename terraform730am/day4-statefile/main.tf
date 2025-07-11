resource "aws_instance" "first" {
    ami = "ami-05ffe3c48a9991133"
    instance_type = "t2.micro"
    key_name = "testdevprod"
    tags = { 
   Name = "day-4-tf"}
  
}


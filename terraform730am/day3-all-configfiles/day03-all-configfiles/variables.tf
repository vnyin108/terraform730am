variable "ami_id" {
    description = "inserting ami value into main"
    type = string
    default = "ami_id"
  
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}
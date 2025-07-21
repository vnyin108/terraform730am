module "project" {
    source = "../day9-modules"
    ami_id = "ami-05ffe3c48a9991133"
    instance_type = "t2.micro"
    az="us-east-1a"


}
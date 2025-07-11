terraform {
  backend "s3" {
    bucket = "backendstatefilecommon"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
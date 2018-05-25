provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket  = "mycloudlabbucket-terraform-state"
    key     = "terraform.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "mycloudlabbucket-terraform-state"  
  
  versioning {    
    enabled = true  
  }
  
  lifecycle {    
    prevent_destroy = true  
  }
}

output "s3_bucket_arn" {  
  value = "${aws_s3_bucket.terraform_state.arn}"
}

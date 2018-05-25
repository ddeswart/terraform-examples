provider "aws" {
  region = "eu-west-2"
}

## Backend ##
terraform {
  backend "s3" {
    bucket  = "mycloudlabbucket-terraform-state"
    key     = "terraform.tfstate"
    region  = "eu-west-2"
    encrypt = true
    dynamodb_table = "terraform-state-lock"
  }
}

## Resources for Backend ##
resource "aws_s3_bucket" "terraform_state" {
  bucket = "mycloudlabbucket-terraform-state"  
  
  versioning {    
    enabled = true  
  }
  
  lifecycle {    
    prevent_destroy = true  
  }
}

resource "aws_dynamodb_table" "terraform_statelock" {
  name           = "terraform-state-lock"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }
}

output "s3_bucket_arn" {  
  value = "${aws_s3_bucket.terraform_state.arn}"
}

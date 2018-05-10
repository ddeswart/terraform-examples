provider "aws" {
	region = "eu-west-2"
}

resource "aws_instance" "example" {
	ami = "ami-f4f21593"
	instance_type = "t2.micro"

	tags {
	Name = "terraform-example"
	}
}

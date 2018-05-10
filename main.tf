provider "aws" {
	region = "eu-west-2"
}

resource "aws_instance" "example" {
	ami = "ami-f4f21593"
	instance_type = "t2.micro"

	user_data = <<-EOF
        	    #!/bin/bash              
		    echo "Hello, World" > index.html              
		    nohup busybox httpd -f -p 8080 &              
		    EOF

	tags {
	Name = "terraform-example"
	}
}

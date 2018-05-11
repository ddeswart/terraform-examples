provider "aws" {
	region = "eu-west-2"
}

resource "aws_instance" "example" {
	ami = "ami-c12dcda6"
	instance_type = "t2.micro"
	vpc_security_group_ids = ["${aws_security_group.instance.id}"]

	user_data = <<-EOF
		    #!/bin/bash
		    sudo yum update -y
		    sudo yum install httpd -y
		    sudo service httpd start
		    sudo chkconfig httpd on
		    cd /var/www/html
		    sudo touch index.html
		    sudo echo "Hello Cloudgurus!" > index.html
		    EOF

	tags {
	Name = "terraform-example"
	}
}

resource "aws_security_group" "instance" {
	name = "terraform-example-instance"

	ingress {
	from_port = 80
	to_port = 80
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
	}
}

provider "aws" {
  region = "eu-west-2"
}

variable "server_port" {  
  description = "The port the server will use for HTTP requests"
  default = 80
}

resource "aws_instance" "example" {
  ami                    = "ami-c12dcda6"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]

  user_data = <<-EOF
		    #!/bin/bash
		    sudo yum update -y
		    sudo yum install httpd -y
		    sudo service httpd start
		    sudo chkconfig httpd on
		    cd /var/www/html
		    sudo touch index.html
		    sudo echo "Hello Cloud Management gurus! from " > index.html
		    sudo hostname -f >> index.html
		    EOF

  tags {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = "${var.server_port}"
    to_port     = "${var.server_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value = "${aws_instance.example.public_ip}"
}

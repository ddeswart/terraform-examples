provider "aws" {
    version = "2.69.0"
    region="eu-central-1"
}

resource "aws_instance" "machine1" {
    ami           = "ami-0604621e15639f0b7"
    instance_type = {
      "type" = var.instance_type
    }
    availability_zone = "eu-central-1a"
    tags = {
      "type" = var.myTag
    }
}

resource "aws_instance" "machine2" {
    ami           = "ami-0604621e15639f0b7"
    instance_type = {
      "type" = var.instance_type
    }
    availability_zone = "eu-central-1b"
    tags = {
      "type" = var.myTag
    }
}

#resource "aws_network_interface_sg_attachment" "sg_attachment1" {
#  security_group_id    = "sg-8e01a2fb"
#  network_interface_id = "${aws_instance.machine1.primary_network_interface_id}"
#}

#resource "aws_network_interface_sg_attachment" "sg_attachment2" {
#  security_group_id    = "sg-aa750ddc"
#  network_interface_id = "${aws_instance.machine2.primary_network_interface_id}"
#}
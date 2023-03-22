provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

resource "aws_security_group" "terraform-sg" {
  name = "allow_ssh"
  description = "allow-ssh"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2-sg" {
    ami = "ami-0520e698dd500b1d1"
    key_name = "assignment"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.terraform-sg.id}"]
    provisioner "remote-exec" {
      inline [
        "sudo yum install httpd -y",
        "sudo systemctl start httpd.service -y"
      ]
    }
    
}
resource "local_file" "public_IP" {
    content  = "${aws_instance.ec2-sg.public_ip}"
    filename = "public_ip.txt"
}

resource "local_file" "private_key" {
    content  = "${aws_instance.ec2-sg.private_key_pem}"
    filename = "private_key.pem"
}
output "IP-adress" {
  description = "To list the Public IP adress"
  value = "${aws_instance.ec2-sg.public_ip}"
}
output "private-IP"{
  description = "to list the private IP"
  value = "${aws_instance.ec2-sg.private_ip}"
}

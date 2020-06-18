provider "aws" {#the default provider if inside resource block we don’t specify provider argument
    region = "eu-west-1"  
  profile    = "default"
  region     = var.region  #fichier variable region
}

resource "aws_instance" "my_example" {
  ami           = "ami-0ce71448843cb18a1"
  instance_type = "t2.micro"
  provisioner "local-exec"{
    command = "echo ${aws_instance.my_example.public_ip} > ip_add.txt" #le fichier ip_add.txt sera sur la machine locale
}
}
#assigning an elastic IP to the EC2 instance
resource "aws_eip" "ip" {
    vpc = true
    instance = aws_instance.my_example.id
}


provider "aws" {
   profile    = "default"
   region     = "eu-west-1"
 }

resource "aws_instance" "vm" {
  ami = "ami-0019f18ee3d4157d3" #Centos7
  instance_type = "t3a.medium"
  key_name = "a"
  subnet_id = "subnet-02620a52f168d875d"
  associate_public_ip_address = true
  security_groups = ["sg-05e578fe6b6fb4217",]
}

resource "null_resource" "bash" {
depends_on =[aws_instance.vm,
]
  connection {
    type         = "ssh"
    user          = "centos"
    password      = ""
    host         = "${aws_instance.vm.public_ip}"
    private_key  = "${file("./a.pem")}"
   
  }
  
  provisioner "remote-exec" {
    script = "./script.sh" 
    }

  provisioner "remote-exec" {
    inline = [
      "oc cluster up --public-hostname=${aws_instance.vm.public_ip}"
    ]
    }
  
} 

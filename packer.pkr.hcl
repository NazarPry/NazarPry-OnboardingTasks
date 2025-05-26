packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
    ansible = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "amazon-ebs" "hardened" {
  region          = "eu-central-1"
  ami_name        = "hardened-ubuntu-nazar"
  source_ami      = "ami-03250b0e01c28d196"  
  instance_type   = "t2.micro"
  ssh_username    = "ubuntu"
  ssh_keypair_name = "MyInstance"
  ssh_private_key_file = "MyInstance.pem"
  ssh_timeout     = "5m"
  ami_description = "Ubuntu 22.04 with OS Hardening by Nazar"
  associate_public_ip_address = true
  


}

build {
  sources = ["source.amazon-ebs.hardened"]
  
  provisioner "ansible" {
    playbook_file   = "playbook.yaml"
    user            = "ubuntu"
  }
}

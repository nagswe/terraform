# Terraform wokspace



vim main.tf 

provider "aws" {
region = "ap-south-1"
}

locals {
env_name = "${terraform.workspace}-"
}

resource "aws_instance" "one" {
ami = ""
instance_type = "t2.micro"
tags = {
Name = local.env_name
}
}

resource "aws_ebs_volume" "example" {
  availability_zone = "ap-south-1"
  size              = 40

  tags = {
    Name = local.env_name
  }
}


terraform init
terraform plan
terraform apply --auto-approve
terraform workspace new prod
terraform destroy --auto-approve


terraform workspace show
terraform workspace list
terraform workspace test
terraform workspace select default
terraform workspace delete prod

#Alias and providers

provider "aws" {
region = "ap-south-1"
}

provider "aws" {
alias = "east"
region = "us-east-1"
}


resource "aws_instance" "one" {
ami = ""
instance_type = "t2.micro"
tags = {
Name = "mumbai"
}
}

resource "aws_instance" "two" {
ami = ""
instance_type = "t2.micro"
provider = "aws.east"
tags = {
Name = "nvirgina"
}
}

terraform destroy --auto-approve

# local files concept

provider "aws" {
region = "ap-south-1"
}

resource "local_file" "one" {
filename = "/root/nagesh.txt"
content = "hai all good morning"
}

terraform init
terraform palan
terraform fmt
terraform validate
terraform apply --auto-approve
terraform destroy --auto-approve

# terraform versioning

vi main.tf

provider "aws" {
region = "ap-south-1"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.49.0"
    }
  }
}

terraform init -upgrade

provider "aws" {
region = "ap-south-1"
}


terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.5.1"
    }
  }
}

terraform init -upgrade

provider "aws" {
region = "ap-south-1"
}


terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "<2.5.1"
    }
  }
}

terraform init -upgrade

provider "aws" {
region = "ap-south-1"
}


terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = ">2.0.0, <2.2.3"
    }
  }
}

terraform init -upgrade

# terraform modules

vi main.tf

module "my_instance_module" {
 source = "./modules/instances"
 ami = "ami-069f1a13711c4eb69"
 instance_type = "t2.micro"
 instance_name = "myvm01"
}
module "s3_module" {
source = "./modules/buckets"
bucket_name = "abc123456"
}

vi provider.tf

provider "aws" {
region = "ap-south-1"
}


mkdir modules
cd modules/
mkdir instances
mkdir buckets
ll
cd instances/
vi main.tf

resource "aws_instance" "my_instance" {
 ami = var.ami
 instance_type = var.instance_type
 tags = {
 Name = var.instance_name
 }
}

vi variable.tf

variable "ami" {
 type = string
}
variable "instance_type" {
 type = string
}
variable "instance_name" {
 description = "Value of the Name tag for the EC2 instance"
 type = string
}

cd 
yum install tree

cd modules/buckets/
vim main.tf

resource "aws_s3_bucket" "b" {
bucket = var.bucket_name
}

vi variable.tf

variable "bucket_name" {
type = string
}

cd 
terraform init
terraform apply --auto-approve
terraform destroy --auto-approve
rm -rf modules/

# terraform lifecycle

vi main.tf

provider "aws" {
region = "ap-south-1"
}

resource "aws_instance" "one" {
ami = ""
instance_type = "t2.micro"
tags = {
Nmae = "mumbai"
}
lifecycle {
prevent_destroy = true
}
}

terraform init
terraform plan
terraform apply --auto-approve

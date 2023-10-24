terraform {
  backend "s3" {
    #bucket exists already
    bucket = "sedem-terra333-bucket"
    key    = "cicd-git-demo2/terraform.tfstate"
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.17.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "project_region"
}
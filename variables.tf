variable "region" {
  description = "The AWS region where resources will be created."
  default     = "eu-central-1"
}

variable "subnet_availability_zone_1" {
  description = "The AWS Availability Zone where the first public subnet will be created"
  default     = "eu-central-1a"
}

variable "subnet_availability_zone_2" {
  description = "The AWS Availability Zone where the second public subnet will be created"
  default     = "eu-central-1b"
}

variable "instance_type" {
  description = "The type of EC2 instance for the Express backend."
  default     = "t2.micro"
}

variable "ami" {
  description = "The ami identifier"
  default     = "ami-0de02246788e4a354"
}

variable "cloudfront_prefix_id" {
  description = "CloudFront prefix list ID"
  default     = "pl-a3a144ca"
}

variable "environment" {
  description = "The environment name"
  default     = "dev"
}

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-north-1"
}

variable "aws_access_key" {
  description = "AWS access key"
  type        = string 
  default     = ""
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  default     = ""
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "terra-front"
}
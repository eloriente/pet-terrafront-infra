variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-west-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "terra-front"
}

variable "env" {
  description = "Environment for the project (e.g., dev, prod)"
  type        = string
}
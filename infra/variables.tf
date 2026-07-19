variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone used by the subnets"
  type        = string
}
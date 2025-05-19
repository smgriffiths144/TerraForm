variable "ami" {
  type        = string
  description = "AL2023 in us-east-1"   #"Ubuntu AMI ID in eu-central-1 Region"
  default     = "ami-0e449927258d45bc4" #"ami-065deacbcaac64cf2"
}

variable "instance_type" {
  type        = string
  description = "Instance type"
  default     = "t2.micro"
}

variable "name_tag" {
  type        = string
  description = "Name of the EC2 instance"
  default     = "My EC2 Instance"
}
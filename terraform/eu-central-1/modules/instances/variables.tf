variable "ENV" {
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "PUBLIC_SUBNETS" {
  type = list
}

variable "PRIVATE_SUBNETS" {
  type = list
}

variable "VPC_ID" {
}

variable "AWS_REGION" {
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "AMIS" {
  type = map(string)
  default = {
    eu-central-1 = "ami-0cc0a36f626a4fdf5"
  }
}

variable "APP_VOL_TAG" {
	default = "Apps volume"
}

variable "LOG_VOL_TAG" {
	default = "Logs volume"
}	

variable "APP_VOL_NAME" {
  default = "/dev/xvdh"
}

variable "LOG_VOL_NAME" {
  default = "/dev/xvdj"
}
variable "AWS_REGION" {
  default = "eu-central-1"
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
    eu-central-1 = "ami-02df9ea15c1778c9c"
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
/*variable "vpc_id" {
  type = string
  default = "vpc-071c596018ce79b1c"
}

variable "subnet_id_elb_1" {
  type = string
  default = "subnet-03eea51d381bbee7f"
}

variable "subnet_id_elb_2" {
  type = string
  default = "subnet-0cb3f9a61f8c32c41"
}*/


variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
  description = "cidr para la vpc"
}

//10.0.1.1 - 10.0.1.14
variable "subnet1_priv_cidr" {
  type = string
  default = "10.0.1.0/28"
  description = "cidr para subnet1 priv"
} 

//10.0.1.17 - 10.0.1.30
variable "subnet2_priv_cidr" {
  type = string
  default = "10.0.1.16/28"
  description = "cidr para subnet2 priv"
}

//10.0.1.33 - 10.0.1.46
variable "subnet1_pub_cidr" {
  type = string
  default = "10.0.1.32/28"
  description = "cidr para subnet1 pub"
}

variable "subnet2_pub_cidr" {
  type = string
  default = "10.0.1.48/28"
  description = "cidr para subnet2 pub"
}

variable "az1" {
  type = string
  default = "us-east-1a"
}

variable "az2" {
  type = string
  default = "us-east-1b"
}
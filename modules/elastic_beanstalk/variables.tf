variable "eb_name_app" {
    type = string
    default = "seba-eb-app-test"
}

variable "eb_name_env" {
    type = string
    default = "seba-eb-env-test"
}

variable "stack" {
    type = string
    //default = "arn:aws:elasticbeanstalk:us-east-1::platform/Corretto 17 running on 64bit Amazon Linux 2/3.4.1"
    default = "arn:aws:elasticbeanstalk:us-east-1::platform/Corretto 11 running on 64bit Amazon Linux 2/3.4.1"
    //"64bit Amazon Linux 2 v3.4.1 running Corretto 17"
    //"Corretto 11 running on 64bit Amazon Linux 2/3.4.1"
}

variable "instance_profile" {
    type = string
    default = "aws-elasticbeanstalk-ec2-role"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "db_instance_type" {
    type = string
    default = "db.t2.micro"
}

variable "db_engine" {
    type = string
    default = "mysql"
}

//no es free tier así que ya fue
variable "username" {
  description = "The username for the DB master user"
  type        = string
  sensitive = true
  default = "admin"
}
variable "password" {
  description = "The password for the DB master user"
  type        = string
  sensitive = true
  default = "password"
}

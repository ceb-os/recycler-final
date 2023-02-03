
#importing network module
module "network"{
  source = "../network"
}

resource "aws_elastic_beanstalk_application" "seba_eb_app" {
  name        = var.eb_name_app
  description = "Seba's elastic beanstalk test"
}

resource "aws_elastic_beanstalk_environment" "seba_eb_env" {
  name        = var.eb_name_env
  description = "Seba's elastic beanstalk test"
  solution_stack_name = var.stack
  application = aws_elastic_beanstalk_application.seba_eb_app.name

//choosing vpc
  setting {
  namespace = "aws:ec2:vpc"
  name = "VPCId"
  #vpc id
  value = module.network.vpc_id
}

//choosing subnet within vpc
setting {
  namespace = "aws:ec2:vpc"
  name = "Subnets"
  #subnet id
  //value = "${module.network.subnet1_priv_id},${module.network.subnet2_priv_id}"
  value = module.network.subnet1_priv_id
}

//public load balancer
setting {
  namespace = "aws:ec2:vpc"
  name = "ELBScheme"
  value = "public"
}

setting {
  namespace = "aws:ec2:vpc"
  name      = "ELBSubnets"
  value = "${module.network.subnet1_pub_id},${module.network.subnet2_pub_id}"
  //value = module.network.subnet1_priv_id
}


#this setting is to configure ec2 instances on beanstalk, instance profiles are used to allow
#iam users and aws services to make api calls
setting {
  namespace = "aws:autoscaling:launchconfiguration"
  name      = "IamInstanceProfile"
  value     = var.instance_profile
}

#this setting is to configure which instance type will be used
setting {
  namespace = "aws:ec2:instances"
  name      = "InstanceTypes"
  value     = var.instance_type
}

//db subnets
setting {
  namespace = "aws:ec2:vpc"  
  name      = "DBSubnets"
  value     = "${module.network.subnet1_priv_id},${module.network.subnet2_priv_id}"
}

//db instance type
setting {
  namespace = "aws:rds:dbinstance"
  name      = "DBInstanceClass"
  value     = var.db_instance_type
}

//db engine
setting {
  namespace = "aws:rds:dbinstance"
  name      = "DBEngine"
  value     = var.db_engine
}

setting {
  namespace = "aws:rds:dbinstance"
  name      = "DBEngineVersion"
  value     = "8.0"
}

//db deletion policy (when instance is terminated, is a snapshot created or not?)
setting {
  namespace = "aws:rds:dbinstance"
  name      = "DBDeletionPolicy"
  value     = "Delete"
}

//For coupling an rds database to the environment
 setting {
    namespace = "aws:rds:dbinstance"
    name      = "HasCoupledDatabase"
    value     = "true"
  }

//db user
//está todo guardado en el json de drive
setting {
  namespace = "aws:rds:dbinstance"
  name      = "DBUser"
  value     = var.username
}

//db user password
setting {
  namespace = "aws:rds:dbinstance"
  name      = "DBPassword"
  value     = var.password
}


#this setting is to choose min and max instances in case of autoscaling
setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = 1
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = 2
  }

#NPI
setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
  }

#for elastic balancer
setting {
  namespace = "aws:elasticbeanstalk:environment"
  name      = "LoadBalancerType"
  value     = "application"
}

#for healthchecks
setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
  }

  /// averiguar para qué son
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "LoadBalanced"
  }
  
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerIsShared"
    value     = "false" # EBS Created and Managed
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "Port"
    value     = 80
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "Protocol"
    value     = "HTTP"
  }
///
}
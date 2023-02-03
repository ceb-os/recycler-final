//within this module the network module is called as well
module "elastic_beanstalk" {
    source = "./modules/elastic_beanstalk"
}

//within this module the s3 module is called as well
module "s3" {
    source = "./modules/s3"
}


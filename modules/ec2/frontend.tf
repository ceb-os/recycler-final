#importing network module
module "network"{
  source = "../network"
}
resource "aws_instance" "recycler_ec2_frontend" {
    ami           = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    subnet_id     = module.network.subnet1_pub_id
    key_name      = "recycler_key"
    vpc_security_group_ids = [aws_security_group.allow_ssh_backend.id]
    user_data = file("./modules/ec2/user_data_frontend.sh")
    tags = {
        Name = "recycler_frontend"
    }
}
resource "aws_network_interface" "nwi_recycler_frontend" {
  subnet_id       = module.network.subnet1_pub_id
  attachment {
    instance     = aws_instance.recycler_ec2_frontend.id
    device_index = 1
  }
}
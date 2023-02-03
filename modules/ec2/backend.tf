resource "aws_instance" "recycler_ec2_backend" {

    ami           = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    subnet_id     = module.network.subnet1_pub_id
    key_name      = "recycler_key"
    vpc_security_group_ids = [aws_security_group.allow_ssh_backend.id]
    user_data = file("./modules/ec2/user_data_backend.sh")
    tags = {
        Name = "recycler_backend"
    }
}

resource "aws_network_interface" "nwi_recycler_backend" {
  subnet_id       = module.network.subnet1_pub_id
  attachment {
    instance     = aws_instance.recycler_ec2_backend.id
    device_index = 1
  }
}
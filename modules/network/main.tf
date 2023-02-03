resource "aws_vpc" "vpc_sebu_test" {
  cidr_block = var.vpc_cidr
   tags = {
    Name = "vpc_sebu_test"
  }
}

//para el backend
resource "aws_subnet" "subnet1_priv_sebu_test" {
    vpc_id = aws_vpc.vpc_sebu_test.id
    cidr_block = var.subnet1_priv_cidr
    availability_zone = var.az1
     tags = {
      Name = "subnet1_priv_sebu_test"
  }
}


resource "aws_subnet" "subnet2_priv_sebu_test" {
    vpc_id = aws_vpc.vpc_sebu_test.id
    cidr_block = var.subnet2_priv_cidr
     tags = {
      Name = "subnet2_priv_sebu_test"
  }
}

//para las subnets públicas
//enables resources in your public subnets (such as EC2 instances) to connect to the internet if the resource has a public IPv4 address or an IPv6 address. 
//Similarly, resources on the internet can initiate a connection to resources in your subnet using the public IPv4 address or IPv6 address
resource "aws_internet_gateway" "ig_sebu_test" {
  vpc_id = aws_vpc.vpc_sebu_test.id
  tags = {
    Name = "ig_sebu_test"
  }
}

resource "aws_subnet" "subnet1_pub_sebu_test" {
    vpc_id            = aws_vpc.vpc_sebu_test.id
    cidr_block        = var.subnet1_pub_cidr
    availability_zone = var.az1
    map_public_ip_on_launch = true

    tags = {
        Name = "subnet publica"
    }
}

resource "aws_subnet" "subnet2_pub_sebu_test" {
    vpc_id            = aws_vpc.vpc_sebu_test.id
    cidr_block        = var.subnet2_pub_cidr
    availability_zone = var.az2
    map_public_ip_on_launch = true

    tags = {
        Name = "subnet publica"
    }
}

resource "aws_route_table" "rt_ig_sebu_test_pub" {
  vpc_id = aws_vpc.vpc_sebu_test.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.ig_sebu_test.id
  }

  tags = {
    Name = "route table internet gateway"
  }
}

//ROUTE TABLE ASSOCIATION FOR INTERNET GATEWAY
//route table association to subnet
resource "aws_route_table_association" "as1_rt_ig_sebu_test" {
  subnet_id = aws_subnet.subnet1_pub_sebu_test.id
  route_table_id = aws_route_table.rt_ig_sebu_test_pub.id
}

resource "aws_route_table_association" "as2_rt_ig_sebu_test" {
  subnet_id = aws_subnet.subnet2_pub_sebu_test.id
  route_table_id = aws_route_table.rt_ig_sebu_test_pub.id
}


//---- NAT---
//instances in a private subnet can connect to services outside your VPC


//ip elastica
resource "aws_eip" "eip_rec" {
    vpc = true
    tags = {
      Name = "sebu-ip-elastica"
    }
}

//nat
resource "aws_nat_gateway" "nat_g_sebu_test" {
    allocation_id = aws_eip.eip_rec.id
    subnet_id = aws_subnet.subnet1_pub_sebu_test.id
    depends_on = [
        aws_internet_gateway.ig_sebu_test
    ]
    tags = {
        Name = "nat gateway"
    }
}

//route table for nat, taking traffic from the private subnets to the internet
resource "aws_route_table" "rt_sebu_test_nat" {
  vpc_id = aws_vpc.vpc_sebu_test.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_nat_gateway.nat_g_sebu_test.id
  }

  tags = {
    Name = "rt_nat_sebu_test"
  }
}

//ROUTE TABLE ASSOCIATION FOR NAT GATEWAY
//to route traffic from private subnet to the nat gateway
resource "aws_route_table_association" "as1_rt_sebu_test_priv" {
  subnet_id = aws_subnet.subnet1_priv_sebu_test.id
  route_table_id = aws_route_table.rt_sebu_test_nat.id
}


resource "aws_route_table_association" "as2_rt_sebu_test_priv" {
  subnet_id = aws_subnet.subnet2_priv_sebu_test.id
  route_table_id = aws_route_table.rt_sebu_test_nat.id
}

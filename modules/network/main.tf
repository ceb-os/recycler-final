resource "aws_vpc" "vpc_recycler" {
  cidr_block = var.vpc_cidr
   tags = {
    Name = "vpc_recycler"
  }
}

resource "aws_subnet" "subnet1_pub_recycler" {
    vpc_id            = aws_vpc.vpc_recycler.id
    cidr_block        = var.subnet1_pub_cidr
    availability_zone = var.az1
    map_public_ip_on_launch = true

    tags = {
        Name = "subnet publica"
    }
}

//para las subnets públicas
//enables resources in your public subnets (such as EC2 instances) to connect to the internet if the resource has a public IPv4 address or an IPv6 address. 
//Similarly, resources on the internet can initiate a connection to resources in your subnet using the public IPv4 address or IPv6 address
resource "aws_internet_gateway" "ig_recycler" {
  vpc_id = aws_vpc.vpc_recycler.id
  tags = {
    Name = "ig_recycler"
  }
}

//route traffic from instance to all
resource "aws_route_table" "rt_ig_recycler_pub" {
  vpc_id = aws_vpc.vpc_recycler.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.ig_recycler.id
  }

  tags = {
    Name = "route table internet gateway"
  }
}

//ROUTE TABLE ASSOCIATION FOR INTERNET GATEWAY
//route table association to subnet
resource "aws_route_table_association" "as1_rt_ig_recycler" {
  subnet_id = aws_subnet.subnet1_pub_recycler.id
  route_table_id = aws_route_table.rt_ig_recycler_pub.id
}
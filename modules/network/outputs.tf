output "vpc_id"{
    value = aws_vpc.vpc_recycler.id
}

output "subnet1_pub_id" {
    value = aws_subnet.subnet1_pub_recycler.id
}

output "vpc_id"{
    value = aws_vpc.vpc_sebu_test.id
}

output "subnet1_priv_id" {
    value = aws_subnet.subnet1_priv_sebu_test.id
}

output "subnet2_priv_id" {
    value = aws_subnet.subnet2_priv_sebu_test.id
}

output "subnet1_pub_id" {
    value = aws_subnet.subnet1_pub_sebu_test.id
}

output "subnet2_pub_id" {
    value = aws_subnet.subnet2_pub_sebu_test.id
}
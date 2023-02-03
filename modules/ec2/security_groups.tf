resource "aws_security_group" "allow_ssh_backend" {
  vpc_id = module.network.vpc_id
    ingress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["10.0.0.0/16"]
    }

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "recycler sg backend"
    }
}

resource "aws_security_group_rule" "allow_my_pc" {
    type        = "ingress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["181.170.187.107/32"]
    security_group_id = aws_security_group.allow_ssh_backend.id
}


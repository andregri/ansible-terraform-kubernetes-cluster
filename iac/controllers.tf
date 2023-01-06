module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  count = 2

  name = "controller-${count.index}"

  ami                    = "ami-0574da719dca65348" # ubuntu 22 us-east
  instance_type          = "t2.micro"
  key_name               = "kthw"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.allow_etcd.id, aws_security_group.allow_ssh.id]
  subnet_id              = aws_default_subnet.default[count.index].id

  associate_public_ip_address = true

  tags = {
    Terraform   = "true"
    Project     = "kubernetes-the-hard-way"
  }
}

resource "aws_security_group" "allow_etcd" {
  name        = "allow_etcd"
  description = "Allow etcd traffic on port 2379 and 2380"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    description      = "Port 2379"
    from_port        = 2379
    to_port          = 2380
    protocol         = "tcp"
    cidr_blocks      = aws_default_subnet.default.*.cidr_block
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
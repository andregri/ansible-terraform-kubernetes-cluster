module "ec2_workers" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  count = 2

  name = "worker-${count.index}"

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
    Type        = "workers"
  }
}
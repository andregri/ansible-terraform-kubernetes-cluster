resource "local_file" "inventory" {
  content  = templatefile(
    "${path.module}/templates/inventory.tftpl",
    { 
        controller-0-public-ip   = module.ec2_instance[0].public_ip,
        controller-0-private-ip  = module.ec2_instance[0].private_ip,
        controller-0-private-dns = module.ec2_instance[0].private_dns,
        controller-1-public-ip   = module.ec2_instance[1].public_ip,
        controller-1-private-ip  = module.ec2_instance[1].private_ip,
        controller-1-private-dns = module.ec2_instance[1].private_dns,
        worker-0-public-ip       = module.ec2_workers[0].public_ip,
        worker-0-private-ip      = module.ec2_workers[0].private_ip,
        worker-0-private-dns     = module.ec2_workers[0].private_dns,
        worker-1-public-ip       = module.ec2_workers[1].public_ip,
        worker-1-private-ip      = module.ec2_workers[1].private_ip,
        worker-1-private-dns     = module.ec2_workers[1].private_dns,
        ssh-private-key          = "kthw.pem"
    }
  )
  filename = "${path.module}/../ansible/inventory"
}
# IaC
1. Create a Key Pair named `kthw` on AWS and copy it into `ansible` folder
2. Run terraform
```bash
cd iac
source ./env
terraform init
terraform apply
```

# Ansible

```bash
brew install cfssl

chmod 400 kthw.pem

ansible-playbook -i inventory certificates/certificates-playbook.yml

ansible-playbook -i inventory certificates/distribute-certificates-playbook.yml

ansible-playbook -i inventory controllers.yml
```
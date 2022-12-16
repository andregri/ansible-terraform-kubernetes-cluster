# IaC

```bash
cd iac
source ./env
terraform init
terraform apply
```

# Ansible

```bash
brew install cfssl
ansible-playbook certificates/certificates-playbook.yml

chmod 400 kthw.pem
export ANSIBLE_HOST_KEY_CHECKING=False

ansible-playbook -i inventory certificates/distribute-certificates-playbook.yml

ansible-playbook -i inventory install-etcd.yml
```
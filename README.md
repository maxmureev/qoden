# Terraform

### First time Terraform initialization
Add keys to file `~/.aws/credentials`
```
[qoden]
aws_access_key_id = AKIAIOSFODNN7EXAMPLE
aws_secret_access_key = wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

Create file for DB secrets `terraform/terraform.tfvars` with username and password to DB instance
```
db_user = "db_user_here"
db_pass = "db_pass_here"
```

Init backend
```
cd terraform/
terraform init
```

### Deploy infrastructure to AWS

```
terraform plan
terraform apply
```

# Ansible

Install boto library for use EC2 external inventory script

```pip install boto```

### Deploy WEB server side

```
export AWS_PROFILE=qoden
cd ansible
ansible-playbook common.yml -i inventory/ -e target=qoden-ue1a-web-00
```

### Deploy PostgreSQL side

Put vault password to `$HOME/.ansible/vault_password_file`
```
export AWS_PROFILE=qoden
cd ansible
ansible-playbook db.yml -i inventory/ -e target=qoden-ue1a-web-00
```

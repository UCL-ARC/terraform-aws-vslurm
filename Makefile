SHELL := /bin/bash
.PHONY: *

define terraform-apply
	. init.sh $$ \
    echo "Running: terraform apply on $(1)" && \
    cd $(1) && \
	terraform init -upgrade && \
	terraform validate && \
	terraform apply --auto-approve
endef

define terraform-destroy
	. init.sh $$ \
    echo "Running: terraform destroy on $(1)" && \
    cd $(1) && \
	terraform apply -destroy --auto-approve
endef

ec2-vslurm:
	$(call terraform-apply, ./ec2-vslurm)

ec2-vslurm-destroy:
	$(call terraform-destroy, ./ec2-vslurm)

ec2-vslurm-ssh:
	cd ./ec2-vslurm && ./ssh.sh

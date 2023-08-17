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

define terraform-plan
	. init.sh $$ \
    echo "Running: terraform plan on $(1)" && \
    cd $(1) && \
	terraform init -upgrade && \
	terraform validate && \
	terraform plan
endef

define terraform-destroy
	. init.sh $$ \
    echo "Running: terraform destroy on $(1)" && \
    cd $(1) && \
	terraform apply -destroy --auto-approve
endef

ec2-vslurm:
	$(call terraform-apply, ./ec2-vslurm)

ec2-vslurm-dry-run:
	$(call terraform-plan, ./ec2-vslurm)

ec2-vslurm-destroy:
	$(call terraform-destroy, ./ec2-vslurm)

ec2-vslurm-ssh:
	cd ./ec2-vslurm && ./scripts/ssh_server

clean:
	rm ./*\~ ./*\# \
		./ec2-vslurm/*\~ ./ec2-vslurm/*\# \
		./ec2-vslurm/node/*\~ ./ec2-vslurm/node/*\#

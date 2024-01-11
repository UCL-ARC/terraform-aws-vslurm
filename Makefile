SHELL := /bin/bash
.PHONY: *
terraform_dir = ./vslurm

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

vslurm:
	$(call terraform-apply, $(terraform_dir))

vslurm-dry-run:
	$(call terraform-plan, $(terraform_dir))

vslurm-destroy:
	$(call terraform-destroy, $(terraform_dir))

vslurm-ssh:
	cd $(terraform_dir) && ./scripts/ssh_server

clean:
	rm ./*\~ ./*\# \
		./vslurm/*\~ ./vslurm/*\# \
		./vslurm/node/*\~ ./vslurm/node/*\#

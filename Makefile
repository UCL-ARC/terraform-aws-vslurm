SHELL := /bin/bash
.PHONY: *
vslurm_dir = ./vslurm
vslurm_images_dir = ./vslurm-images

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
	$(call terraform-apply, $(vslurm_dir))

vslurm-images:
	$(call terraform-apply, $(vslurm_images_dir))

vslurm-dry-run:
	$(call terraform-plan, $(vslurm_dir))

vslurm-images-dry-run:
	$(call terraform-plan, $(vslurm_images_dir))

vslurm-destroy:
	$(call terraform-destroy, $(vslurm_dir))

vslurm-images-destroy:
	$(call terraform-destroy, $(vslurm_images_dir))

vslurm-ssh:
	cd $(vslurm_dir) && ../server_ssh.sh

vslurm-images-ssh:
	cd $(vslurm_images_dir) && ../server_ssh.sh

clean:
	rm ./*\~ ./*\# \
		./vslurm/*\~ ./vslurm/*\# \
		./vslurm/compute_node/*\~ ./vslurm/compute_node/*\#

# terraform-aws-vslurm

## vSlurm

A tool for deploying a virtual Slurm cluster on AWS using Terraform.

## Usage

1. Clone the repository
2. Configure the environment variables (see `.example.env`)
3. Run `make vslurm` to deploy the cluster (takes ~10 minutes)
4. Run `make vslurm-ssh` to log in to the cluster on the server node
5. Run `make vslurm-destroy` to tear the cluster down

vSlurm may be deployed in a bootstrapped fashion, or from pre-built images. Append
`IMAGES=T` to all the `make vslurm*` commands to use the `vslurm-images` module.
See [packer-aws-vslurm](https://github.com/UCL-ARC/packer-aws-vslurm) for details.

## Overview

![vSlurm diagram](diagrams/terraform-aws-vslurm.drawio.svg)

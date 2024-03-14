# terraform-aws-vslurm

## vSlurm

⚠️ This repository is still under construction! ⚠️

A tool for deploying a virtual Slurm cluster on AWS using Terraform.

## Usage

1. Clone the repository
2. Configure the environment variables (see `.example.env`)
3. Run `make vslurm` to deploy the cluster (takes ~10 minutes)
4. Run `make vslurm-ssh` to log in to the cluster on the server node
5. Run `make vslurm-destroy` to tear the cluster down

## Overview

![vslurm diagram](diagrams/terraform-aws-vslurm.drawio.svg)

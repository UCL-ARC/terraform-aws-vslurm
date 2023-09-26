# terraform-aws-vslurm

## vslurm

⚠️ This repository is still under construction! ⚠️

A tool for deploying a virtual slurm cluster on AWS using terraform.

## Usage

1. Clone the repository
2. Configure the environment variables (see `.env.sample`)
3. Run `make ec2-vslurm` to deploy the cluster (takes ~10 minutes)
4. Run `make ec2-vslurm-ssh` to log in to the cluster on the server node
5. Run `make ec2-vslurm-destroy` to tear the cluster down

## Overview

![vslurm diagram](diagrams/terraform-aws-vslurm.drawio.svg)

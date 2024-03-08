#!/bin/bash -e

sudo mkdir --mode 0755 /shared
sudo chown root:root /shared
sudo mkdir --mode 0755 /mnt/nfs/home
sudo chown root:root /mnt/nfs/home

sudo dnf -y install slurm-slurmctld python3-pip git nfs-utils
pip install --no-input ansible

sudo setsebool -P use_nfs_home_dirs on

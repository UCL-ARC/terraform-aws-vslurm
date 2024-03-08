#!/bin/bash -e

sudo mkdir --mode 0755 /shared
sudo chown root:root /shared
sudo mkdir --mode 0755 /mnt/nfs/home
sudo chown root:root /mnt/nfs/home

sudo dnf -y install slurm-slurmd slurm-pam_slurm slurm-contribs nfs-utils

sudo setsebool -P use_nfs_home_dirs on

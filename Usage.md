# vSlurm Usage

## Slurm status

Check the status of the cluster with `sinfo`.

Check connectivity to the `slurmctld` with `sinfo ping`.

## Slurm configuration

vSlurm automatically sets up Slurm for "configless" operations.
This means that the configuration is sourced from slurm.conf on the server node.

## Cluster administration

The server node is provided with an ansible playbook to facilitate common tasks.

### Add user accounts

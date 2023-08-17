#!/bin/bash

# Make the prompt useful
/usr/bin/echo "export NICKNAME=${nickname}" > /etc/profile.d/prompt.sh
/bin/sed -i -e 's/\\h/$NICKNAME/g' /etc/bashrc

# Update and install packages
dnf update -y --allowerasing
dnf install -y vim
dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
dnf install -y pdsh pdsh-rcmd-ssh ansible

# Shutdown the instance after a few hours
shutdown +300

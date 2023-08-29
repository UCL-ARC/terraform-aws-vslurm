#!/bin/bash

function tf_output() {
	terraform output -raw "$1"
}

eval "$(tf_output server_ssh_command)"

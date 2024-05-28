#!/bin/bash

# Ensure Ansible is installed
if ! command -v ansible &> /dev/null; then
    echo "Ansible not found. Installing..."
    sudo apt-get update
    sudo apt-get install -y ansible
fi

# Run the Ansible playbook
ansible-playbook -i localhost, -c local playbook.yml


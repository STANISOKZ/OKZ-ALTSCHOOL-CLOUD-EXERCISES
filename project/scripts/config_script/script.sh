#!/bin/bash

# USING BASH SCRIPT TO INSTALL AND CONFIGURE PGSQL, ANSIBLE ENVIROMENTS, GIT DEPENDENCIES, SETTING UP MASTER SLAVE CONNECTION ON UBUNTU SERVER

# sudo chmod u+x script.sh

# ==========
# SSH-KEYGEN
# ==========

# ssh-keygen -t rsa -N // To be executed First (separately) on the terminal
# Copy ssh private key to slave (APPEND ON (/home/admin/.ssh/authorized_keys))

# =========
# variables
# =========

# // Set up a PERSONAL ACCESS TOKEN on github //
github_token="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" 
git_user="STANISOKZ"
git_repo="OKZ-ALTSCHOOL-CLOUD-EXERCISES"
git_path="./${git_repo}/exams"
host_file="/etc/ansible/hosts"
# ===================================
home_path="/home/ansibleservers"
.ssh_path="${home_path}/.ssh"
config_path="${home_path}/.ssh/config"
inventory_path="${home_path}/inventory.txt"
# ==================================
Hostname="54.226.236.255"
IdentityFile="${home_path}/.ssh/new"
User="${ansible_user}"
# ==================================
server_name="clientone"
ansible_host="${Hostname}"
ansible_connection="ssh"
ansible_user="admin"

# ==================================
# ANSIBLE INSTALLATION ON MASTER
# ==================================

# Update and upgrade Ansible server

sudo yum update && sudo yum upgrade -y

# Install Ansible on Master (UBUNTU)

sudo amazon-linux-extras install ansible2 -y

ansible --version

# ============================================
# INSTALLATION OF GIT DEPENDENCIES ON MASTER
# ============================================

# Install git dependencies

sudo yum install git -y

# Confirm git installed version

sudo git --version

# Clone git repository into Ansible server

git clone https://${github_token}@github.com/${git_user}/${git_repo}.git

# Make working directory in working repository

sudo mkdir -p ./${git_path}

# Move bash script into git repository

sudo mv script.sh ./${git_path}

# =====================================
# CONFIURING MASTER SLAVE CONNECTION
# =====================================

# Append Host name into ansible hosts file

sudo echo -e "[laravel-host]\n${ansible_host}" >> ${host_file}

# Create a config file to define host configurations

sudo echo -e "Hostname ${Hostname}\nIdentityFile ${IdentityFile}\nUser ${ansible_user}" > ${config_path}

# Creating the inventory file

sudo echo "${server_name} ansible_host=${ansible_host} ansible_connection=${ansible_connection} ansible_user=${ansible_use}" > ${inventory_path}

# Executing the inventory.txt

# ansible slave -m ping -i inventory.txt -v // To be executed

#!/bin/bash

# Define absolute paths
TF_DIR="Terraform"
INVENTORY_FILE="Ansible/inventory"
chmod 664 $INVENTORY_FILE
# Navigate to the Terraform directory
cd $TF_DIR

# Load Terraform outputs
PUBLIC_IP=$(terraform output -raw vm_public_ip)
USERNAME=$(terraform output -raw vm_username)
cd ..
# Write to the inventory file
cat > $INVENTORY_FILE <<EOL
[azure_vm]
$PUBLIC_IP ansible_user=$USERNAME ansible_ssh_private_key_file=/var/lib/jenkins/.ssh/new_thuan
EOL

echo "Inventory file updated with IP: $PUBLIC_IP and username: $USERNAME"
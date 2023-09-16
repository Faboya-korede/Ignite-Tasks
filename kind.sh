#!/bin/bash

# Install docker

# Update package lists
sudo apt update

# Install required packages
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add Docker repository to apt sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

# Update package lists again to include Docker repository
sudo apt update

# Install Docker Community Edition (CE)
sudo apt install -y docker-ce

# Add current user to the docker group to run docker commands without sudo
sudo usermod -aG docker $USER

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# install kubectl 
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Check if Kind is already installed
if ! command -v kind &> /dev/null
then
    echo "Kind is not installed. Installing Kind..."
    
    # Download Kind binary
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
    chmod +x ./kind

    # Move Kind binary to a directory in PATH
    sudo mv ./kind /usr/local/bin/

    echo "Kind installed successfully!"
else
    echo "Kind is already installed."
fi

# Create a Kind cluster
kind create cluster --name nodejs

# Get the kubeconfig for the cluster
kind get kubeconfig --name=nodejs > kubeconfig.yaml

echo "Kind cluster 'nodejs' created and kubeconfig set!"
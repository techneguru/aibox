#!/bin/bash

set -e

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install necessary packages
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common python3-pip

# Install Docker
if ! command -v docker &> /dev/null; then
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt update
  sudo apt install -y docker-ce
fi

# Add user to the docker group
sudo usermod -aG docker ${USER}

# Install Docker Compose
if ! command -v docker-compose &> /dev/null; then
  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
fi

# Update pip to the latest version
sudo -H python3 -m pip install --upgrade pip

# Install NVIDIA Docker
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt update
sudo apt install -y nvidia-docker2
sudo systemctl restart docker

# Verify NVIDIA Docker installation
if ! sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi; then
  echo "NVIDIA Docker installation failed"
  exit 1
fi

# Disable UFW
sudo systemctl stop ufw
sudo systemctl disable ufw

# Install nativeauthenticator for JupyterHub
sudo -H python3 -m pip install git+https://github.com/jupyterhub/nativeauthenticator.git

# Create necessary directories
mkdir -p ~/aibox/nginx
mkdir -p ~/aibox/jhub_config
mkdir -p ~/aibox/rocket_mongo_data
mkdir -p ~/aibox/mattermost_data
mkdir -p ~/aibox/heimdall_config
mkdir -p ~/aibox/ansible_playbooks
mkdir -p ~/aibox/kube_config
mkdir -p ~/aibox/portainer_data

# Copy configuration files (assuming they are in the same directory as this script)
cp ./nginx/default.conf ~/aibox/nginx/ || { echo "Failed to copy default.conf"; exit 1; }
cp ./nginx/htpasswd ~/aibox/nginx/ || { echo "Failed to copy htpasswd"; exit 1; }
cp ./kube_config/* ~/aibox/kube_config/ || { echo "Failed to copy kube_config files"; exit 1; }

# Set environment variables
cat <<EOF >> ~/aibox/.env
JUPYTERHUB_ADMIN_USER=adminuser
JUPYTERHUB_ADMIN_PW=supersecret
FLOWISE_URL=http://aibox.local/flowise
LANGFLOW_URL=http://aibox.local/langflow
OLLAMA_URL=http://aibox.local/ollama
KUBERNETES_MASTER_IP=<your_kubernetes_master_ip>
EOF

# Print completion message
echo "Setup complete. Please log out and log back in to apply the Docker group changes."
echo "Run 'docker-compose up -d' in the ~/aibox directory to start the services."

#Testing VSCode Linux
# Create new directory for nginx proxy manager
mkdir -p npm
cd npm
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
# Uninstall old versions
# Setup the repository 
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release -y
# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
# Test the installation
docker-compose --version

# Create a docker-compose configuration file
# Editing the file
cat << EOF >> docker-compose.yml
version: '3'
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: unless-stopped
    ports:
      - '80:80'
      - '81:81'
      - '443:443'
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
EOF

##
sudo docker-compose up -d

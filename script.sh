#!/bin/bash


# install docker 

sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

# Install Docker Compose
apt -y update && \
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# install ansible 
sudo apt-get update
sudo apt install python-pip -y

# switch to the root user

sudo su
pip install ansible

# switch back to your regular user
su - username

# create /etc/ansible directory 

sudo mkdir -p /etc/ansible

# create the inventory file under /etc/ansible and copy and paste 
#the content of the host file under ansible directory of the project to your file

sudo nano /etc/ansible/hosts

# next steps are very important

# edit the sshd_config file to allow the passwordauthentication

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

# restart the ssh service

sudo service ssh restart

# generate ssh keys on your machine
ssh-keygen -t rsa # keep hitting enter then it will generated and stored under ~/.ssh

# copy the public key and private key from the server you want to have control over it
ssh-keyscan -H username@ip_add # in our case ssh-keyscan -H 
# copy your public key id_rsa.pub to your localhost either by using ssh-copy-id or manully to ~/.ssh/authorized_keys

ssh-copy-id localhost

# check wether if you are connected to the hosts defined in hosts file 

ansible all -m ping

# if you set everything properly you will have green message otherwise 
# you must to review the previous steps and repeat the procedure

# install the docker and docker-compose modules
pip install docker docker-compose
# now run you play book

ansible-playbook ansible-playbook.yml


# Wait until the containers are up and running
while ! ( curl http://10.0.2.21 ) &&  (curl 10.0.2.17)
do
  echo "$(date) - Waiting for both Docker containers to be up and running"
  sleep 1
done
echo "$(date) - Welcome to nginx"

# Check the status of the high-availability load-balancer:
curl 10.0.2.21
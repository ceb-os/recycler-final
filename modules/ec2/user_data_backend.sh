#!/bin/bash
echo "creating recycler user, setting password and shell"
useradd -m recycler -s /bin/bash
echo "recycler:recycler123" | chpasswd
usermod -aG sudo recycler
echo "changing to recycler user"
su -l recycler
cd /home/recycler/
echo "downloading jdk"
echo recycler123 | sudo -S wget https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz
echo "unzipping jdk"
tar -xvf openjdk-11+28_linux-x64_bin.tar.gz
echo "moving jdk directory to /opt/"
echo "recycler123" | sudo -S mv jdk-11 /opt/
echo "setting environment variables for java"
echo "JAVA_HOME='/opt/jdk-11'" >> /home/recycler/.profile 
echo "PATH=\"\$JAVA_HOME/bin:\$PATH\"" >> /home/recycler/.profile
echo "export PATH" >> /home/recycler/.profile
echo "downloading maven"
echo recycler123 | sudo -S wget https://dlcdn.apache.org/maven/maven-3/3.8.7/binaries/apache-maven-3.8.7-bin.tar.gz
tar -xvf apache-maven-3.8.7-bin.tar.gz
echo "moving maven to /opt/"
echo "recycler123" | sudo -S mv apache-maven-3.8.7 /opt/
echo "setting environment variables for maven"
echo "M2_HOME='/opt/apache-maven-3.8.7'" >> /home/recycler/.profile
echo "PATH=\"\$M2_HOME/bin:\$PATH\"" >> /home/recycler/.profile
echo "export PATH" >> /home/recycler/.profile
source .profile
apt install -y nginx
#echo recycler123 | sudo -S apt-get update
#echo recycler123 | sudo -S apt-get -y install ca-certificates curl gnupg lsb-release
#echo recycler123 | sudo -S mkdir -p /etc/apt/keyrings
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | echo recycler123 | sudo -S gpg --dearmor -o /etc/apt/keyrings/docker.gpg
#echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#echo recycler123 | sudo -S apt-get update
#echo recycler123 | sudo -S apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
#curl -SL https://github.com/docker/compose/releases/download/v2.15.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
#echo recycler123 | sudo -S ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose


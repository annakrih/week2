#!/usr/bin/env bash

exec > >(tee /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1

sudo yum update
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum -y remove java-1.7.0-openjdk
sudo yum -y install java-1.8.0

sudo yum -y install docker

sudo service docker start
sudo usermod -a -G docker ec2-user

curl --silent --location https://rpm.nodesource.com/setup_9.x | sudo bash -
sudo yum -y install nodejs
sudo yum -y install gcc-c++ make

sudo yum install jenkins -y
sudo usermod -a -G docker jenkins

sudo yum install git -y

sudo service jenkins start

sudo wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
curl --silent --location https://rpm.nodesource.com/setup_6.x | sudo bash -
sudo yum -y install yarn

touch ec2-init-done.markerfile
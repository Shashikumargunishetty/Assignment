#!/bin/bash

# This script is used to create the infra on AWS and deploy the docker image into that 

terraform init

terraform apply -y 

# Deploy the docker image into the ec2 instance 

ip_address=$(cat 'public_ip.txt')

ssh -i assignment.pem ec2-user@${ip_address} 'docker pull assignment-image:${BUILDNUMBER}'


ssh -i assignment.pem ec2-user@${ip_address} 'docker eun -d -p 5000:5000 assignment-image:${BUILDNUMBER}'


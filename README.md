# Deployment guide 

## ec2.tf

ec2.tf terraform script is used to create the ec2 instance on AWS.

## deploy_script.sh

deploy_script.sh script is used to run the above terraform script to create the ec2 instance and deploy the docker image into that. 

## Jenkins file
we have jenkins file, which will take the source code, build, run the test cases, build the docker image, push the image and deploy the image to ec2 instance upon approval. 


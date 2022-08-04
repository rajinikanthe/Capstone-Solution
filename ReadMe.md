# Task 0: Environment Setup
  ## 0.1 Spin up an ec2 t2.micro with a security group that allows us to ssh into the machine
  ## 0.2 Create and attach IAM role with AdministratorAccess to the ec2
  ![image](https://user-images.githubusercontent.com/97882602/180923880-913c0142-2515-4702-a23a-85328d1b277b.png)
  ## 0.3 Install AWS CLI. Select Linux from the dropdown.
  https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
  ## 0.4 Install Terraform. Select Linux from the dropdown.
  https://learn.hashicorp.com/tutorials/terraform/install-cli
  ## 0.5 Install Docker.
  https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04
  ## 0.6 Install Eksctl. Select Linux from the dropdown.
  https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html
  ## 0.7 Install Kubectl. Select Linux from the dropdown.
  https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
  
# Task 1: Setup EKS Cluster
  ## 1.1 Ensure aws-cli is installed and configured in your linux machine with full access to AWS by running below command,
  
  ````
  aws s3 ls
  ````
  ## 1.2 Initialize a bucket in s3 for a backend state store using Terraform. 
  Go to S3. Click create bucket.
  Use a custom name
  ![image](https://user-images.githubusercontent.com/97882602/181164854-6568e728-48e4-4c99-ad8c-b8736ee5b9b4.png)
  
  No other changes in settings
  ![image](https://user-images.githubusercontent.com/97882602/181164897-ac47b0c5-1068-4544-a0d7-c73586b34768.png)
  
  Create bucket.
  ![image](https://user-images.githubusercontent.com/97882602/181164939-fc8cc48d-3039-4493-8a99-e01ca3a60bd9.png) 
  
  ## 1.2 Create terraform folder and provider.tf file in that folder
  ````
  terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.23.0"
    }
  }
  backend "s3" {
    bucket = "sk-capstone-tf"
    key    = "terraform.tfstate"
    region = "us-east-1"
    }
  }

  provider "aws" {
   # Configuration options
    region = "us-east-1"
  }
  ````
  Run below command to initiate terraform
  ````
  terraform init
  ````
  ## 1.3 Create a file for VPC module vpc.tf
  ````
  module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
  
    name = "sk-capstone-vpc"
    cidr = "10.0.0.0/16"
  
    azs             = ["us-east-1a", "us-east-1b"]
    private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
    public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  
    enable_nat_gateway = true
    enable_vpn_gateway = true
  
    tags = {
      Terraform = "true"
      Environment = "dev"
    }
  }
  ````
  ## 1.4 Run below command to check if there are any errors
  ````
  terraform plan
  ````
  ## 1.4 Create a file outputs.tf to get the vpc and subnet IDs(you can get these IDs from console as well)
  ````
  output "vpc_id" {
    description = "ID of project VPC"
    value       = module.vpc.vpc_id
  }
  
  output "privateSubnet1_id" {
    description = "ID of privateSubnet1"
    value       = module.vpc.private_subnets[0]
  }
  output "privateSubnet2_id" {
    description = "ID of privateSubnet2"
    value       = module.vpc.private_subnets[1]
  }
  output "publicSubnet1_id" {
    description = "ID of publicSubnet1"
    value       = module.vpc.public_subnets[0]
  }
  output "publicSubnet2_id" {
    description = "ID of publicSubnet2"
    value       = module.vpc.public_subnets[1]
  }
  ````
  ## 1.5 Run below command to create VPC and to get the VPC and Subnet IDS
  ````
  terraform apply
  ````
  ![tf vpc module implementation](https://user-images.githubusercontent.com/97882602/181165913-5222fb43-77c7-4843-bb74-5ec517a97cdf.PNG)
  
  ![Created outputs for VPC and Subet IDs](https://user-images.githubusercontent.com/97882602/181165925-b8f75733-facb-430f-a45e-2a993bdbae07.PNG)
  
  ## 1.6 Update the VPC and subnet IDs in eks-conf.yaml file from stub siles. Add the file in Cluster directory.
  ![image](https://user-images.githubusercontent.com/97882602/182764712-df101186-40f5-424b-93a8-f1ce8709aa52.png)
  
  ![image](https://user-images.githubusercontent.com/97882602/182765022-74c143d7-fbe5-4f4c-9d6c-feb5475aa594.png)

  Run below command to create an eks cluster
  ````
  eksctl create cluster -f sk-eks-config.yaml
  ````
  ````
  kubectl get nodes
  ````
  ![EKS cluster created and tested if nodes are ready](https://user-images.githubusercontent.com/97882602/181166783-271e62da-dfdb-45db-8b90-daa8532648c5.PNG)
  
  
  ## 1.7 Install Kubectl metric server
  ````
  kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
  ````
  Verify the installation
  ````
  kubectl top nodes
  ````
  ![Metric Server installed and tested](https://user-images.githubusercontent.com/97882602/181166969-814703af-5a06-48ed-90ae-a3f258e648a8.PNG)
  
  ## 1.8 Add file autoscalar.yaml and apply it.
  ````
  kubectl apply -f autoscalar.yaml
  ````
  ![Autoscalar applied](https://user-images.githubusercontent.com/97882602/181167313-6fcbc130-c347-4ea3-b2e7-b558b681072a.PNG)
  
 # Task 2: Deployment of sample application
  ## 2.1 Create an ECR repository to store the docker image of the node application.
  ![image](https://user-images.githubusercontent.com/97882602/181167640-7ce83611-c367-4823-9f4a-e602ed09a280.png)
  
  No other change req
  ![image](https://user-images.githubusercontent.com/97882602/181167701-a03eb532-2833-4ddd-aba2-2253cd6d7be0.png)
  
  ![image](https://user-images.githubusercontent.com/97882602/181167758-d8a2e423-0be4-4baf-9a16-36de38cbcf82.png)
  
  
  ## 2.2 Write a Dockerfile to dockerise the upg-loadme nodejs application. 
  ````
  FROM node:12.18.1
  LABEL maintainer="swapnilkhot36@gmail.com"
  ENV NODE_ENV=production
  WORKDIR /app
  COPY ["package.json", "./"]
  RUN npm install --production
  COPY . .
  EXPOSE 8081
  CMD [ "node", "server.js" ]
  ````
  ## 2.3 Tag & push the docker image to the ECR repository.
  ![image](https://user-images.githubusercontent.com/97882602/181168525-1c906374-5c4c-4c99-93e7-0cbdd483b05f.png)
  
  Follow these steps
  ![image](https://user-images.githubusercontent.com/97882602/181168562-6a4b72a4-3fe8-4137-bcbb-4148988d2fdb.png)
  
  ## 2.4 Check if image is pushed to ecr
  ![6  Image in ecr repo](https://user-images.githubusercontent.com/97882602/181168905-822d72f3-e104-404f-a358-f2af2e5dffd3.PNG)
  
  ## 2.5 Run the image using below command
  ````
  docker images
  ````
  ````
  docker run -itd -p 8081:8081 <image ID>
  ````
  The image id should be displayed after docket images command. Make sure you are using the latest image ID.
  
  ## 2.6 Check if the application is online by hitting "ec2 ip:8081" in browser.
  ![4  Docker Container is running and accessible from browser](https://user-images.githubusercontent.com/97882602/181169549-ae96e0e3-dacc-4910-9cd1-1e2b28a56d36.PNG)

  ## 2.7 Add a node group config to config file:
  Use the last public node config and update taint config and a new name for the ng
  ````
    - name: pub-201-a-2
    labels: { role: workers }
    tags:
      k8s.io/cluster-autoscaler/enabled: "true"
      k8s.io/cluster-autoscaler/my-eks-201: "shared"
    taints:
    - key: "critical"
      value: "true"
      effect: NoSchedule
    instancesDistribution:
      instanceTypes:
        - t2.medium
    desiredCapacity: 0
    minSize: 0
    maxSize: 1
    subnets:
      - sk-capstone-cluster-pub-a
  ````
  
  ## 2.8 Create ng using below command
  ````
   eksctl create nodegroup --config-file=sk-eks-config.yaml
  ````
  
  ## 2.9 Create namespace "demo" using below command
  ````
  kubectl create ns demo
  ````
  ![image](https://user-images.githubusercontent.com/97882602/182538152-3afbd289-d3af-4c0a-a390-9f6672be4ec2.png)
  
  
  
  





  






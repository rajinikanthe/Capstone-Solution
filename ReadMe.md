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
  ## 1.2 Initialize a bucket in s3 for a backend state store using Terraform. 
  Go to S3. Click create bucket.
  Use a custom name
  ![image](https://user-images.githubusercontent.com/97882602/181164854-6568e728-48e4-4c99-ad8c-b8736ee5b9b4.png)
  No other changes in settings
  ![image](https://user-images.githubusercontent.com/97882602/181164897-ac47b0c5-1068-4544-a0d7-c73586b34768.png)
  Create bucket.
  ![image](https://user-images.githubusercontent.com/97882602/181164939-fc8cc48d-3039-4493-8a99-e01ca3a60bd9.png) 




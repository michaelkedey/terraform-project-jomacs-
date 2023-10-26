# AWS Terraform Project (Jomacs)
### Author: michael_kedey
### Date: 19/10/2023
#### Last_modified: 26/10/2023
- **Github: https://github.com/michaelkedey**
- **Linkedin: https://www.linkedin.com/in/michaelkedey**


this is a cloud project which involves provissioning AWS resources via terraform and git actions.

-  Project structure
I have a **src** directory and **README.MD** file in the repository.
1. **terraform-project-jomacs-**

-  The **src** directory serves as the root of the project. It contains a **main.tf** file in which I created resources from **modules** already deffined. It also has other configurations as needed.
1. **terraform-project-jomacs-/src**

-  I have another directory called **modules** in **src** which contains reusable modules 
1. **terraform-project-jomacs-/src/modules**

-  Inside the **modules** directory,  I have **2 sub-directories** which define 2 seperate reusable modules, **vpc** and **ec2**. In these sperate module directories, I deffined the components and resources perculiar to each.
1. **terraform-project-jomacs-/src/modules/vpc**
2. **terraform-project-jomacs-/src/modules/ec2**

- The **vpc** module conatins all configurations for the vpc resource, **the main vpc.tf file, viraibles deffinitions (var.tf), outputs (outputs.tf), providers configuration (providers.tf), and a store.tf file which passes neceasry values to the ssm parameter store.**

- The **Ec2** module also contains all configurations for the instance, the main **ec2.tf file, viraibles deffinitions (var.tf), outputs (outputs.tf), providers configuration (providers.tf), and a data.tf file where I defined a data resource for my ami.**

- I have a **vpc with 3 subnets; two public subnets in two different avaliabilty zones, and a private subnet** which contains my instanace.

- I also have a **load balancer and a listener**, associated with the public subnet, which distributes traffic to the security group in which the instance resdides.

- I have an **Internet Gateway** in the vpc which has a public route table, with routes deffined which send all traffic to the internet. 

- I also have a **NAT Gateway** residing in the public subnet, which has a route table with a route diffined which sends outbount traffic from the **private subnet** through the **NAT Gateway**.

- I have different **security groups** for the **ec2** and the **load balancer**
- I have an **Ec2 instance, with a shell script** which runs at boot time, **installs nginx, sets up reverse proxy, and change the default ssh port**.

- To deploy this infrasrcture, fork or clone the repository to your local environment
- move into the cloned repository, ceate a branch and switch to it
- change directory into the **src directory**, which contains the **main.tf** file
- Go through the code and **read the comments**, and modify the code as necessary
- Run **terraform init**, to initialize the terraform provider configuration
- Run **terraform plan**, and **terraform apply** to have the resources created. 
- I have also automated the deployment of the infrastracture by creating a **ci/cd pipeline** where I have a **.github/workflows directory in my root directory, in which i deffined an action.yml file** The resources get created when I push to main.

- **If you clone the repo, and push to github sometime, remember to take out or modify the .githiub/workflows content**
- **In all your resources will include**
1. vpc
2. 3 subnets
5. nat gateway
6. internet gateway
7. load balancer
8. load balancer listener
9.  eip
10. 2 target groups
12. 2 route tables
14. 2 route table associations
15. 2 routes
17. target group attachement
18. 5 ssm parameter resources
23. ec2 






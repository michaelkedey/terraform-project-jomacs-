# AWS Terraform Project (Jomacs)
#### Author: michael_kedey
#### Date: 19/10/2023
#### Last_modified: 26/10/2023
- **Github: https://github.com/michaelkedey**
- **Linkedin: https://www.linkedin.com/in/michaelkedey**


## This is a cloud project which involves provissioning AWS infrastracture via terraform and automating the deployment via git actions.

#### Project structure
- I have a **src** directory, **README.md** file and, **test_my_code.go** file in the repository.
1. **terraform-project-jomacs-/README.md**
2. **terraform-project-jomacs-/test_my_code.go**
3. **terraform-project-jomacs-/src**

-  The **src** directory serves as the root of the project. It contains a **main.tf** file in which I created resources from **modules** already deffined. It also has other configurations as needed.
1. **terraform-project-jomacs-/src**

-  I have another directory called **modules** in **src** which contains reusable modules defined
1. **terraform-project-jomacs-/src/modules**

-  Inside the **modules** directory,  I have **2 sub-directories** which define 2 seperate reusable modules, **vpc** and **ec2**. In these sperate module directories, I defined the components and resources perculiar to each.
1. **terraform-project-jomacs-/src/modules/vpc**
2. **terraform-project-jomacs-/src/modules/ec2**

- The **vpc** module conatins all configurations for the vpc resource, **the main vpc.tf file, viriables definitions (var.tf), outputs (outputs.tf), providers configuration (providers.tf), and a store.tf file which passes neceasry values to the ssm parameter store.**

- The **Ec2** module also contains all configurations for the instance, the main **ec2.tf file, viriables definitions (var.tf), outputs (outputs.tf), providers configuration (providers.tf), and a data.tf file where I defined a data resource for my ami.**

- I have a **vpc with 3 subnets; two public subnets in two different avaliabilty zones, and a private subnet** which contains my instanace.

- I also have a **load balancer and a listener**, associated with the public subnet, which distributes traffic to the security group in which the instance resides.

- I have an **Internet Gateway** in the vpc which has a public route table, with routes defined which send all traffic to the internet. 

- I also have a **NAT Gateway** residing in the public subnet, which has a route table with a route diffined which only sends outbound traffic from the **private subnet** through the **Internet Gateway**.

- I have different **security groups** for the **ec2** and the **load balancer**
- I have an **Ec2 instance, with a shell script** which runs at boot time, **installs nginx, sets up reverse proxy, and change the default ssh port**.

- I have automated the deployment of the infrastracture by creating a **ci/cd pipeline** where I have a **.github/workflows directory in my root directory, in which i deffined an action.yaml file** The resources get created when I push to main.

- I have automated the testing of my code by  including a **test_my_code.go** in my repository directory.

- **If you clone the repo, and push to github sometime, remember to take out or modify the .githiub/workflows content**

#### To deploy this infrasrcture;
- **download and isnatll terraform by adding the path to your system environent variables**
1. **Fork or clone** the repository to your local environment
2. Move into the cloned repository, **ceate a branch and switch to it**
3. Change directory into the **src directory**, which contains the **main.tf** file
4. Go through the code and **read the comments**, and modify the code as necessary
5. Run **terraform init**, to initialize the terraform provider configuration
6. Run **terraform plan**, and **terraform apply** to have the resources created.
7. Run terraform destroy to destroy all resources after you're done

#### To test this code;
1. Cd into the cloned repository
2. Install **go** and run **go mod init** to initialize go in the respo directory
2. Run the **test_my_code.go** file in the repo by running **go test** 
- **UPDATE**
- the test_my_code.go file is not operational
 
3. This will create the resource, checks for some specifics like the **vpc and subnets, load balancer and instance**, and then destroy them when done

#### In all, your resources will include
1. **vpc**
2. **subnet 1**
3. **subnet 2**
4. **subnet 3**
5. **nat gateway**
6. **internet gateway**
7. **load balancer**
8. **load balancer listener**
9. **eip**
10. **target group**
11. **security group 1**
12. **security group 2**
13. **route table association 1**
14. **route table association 2**
15. **route 1**
16. **route 2**
17. **target group attachement**
18. **ssm parameter resource 1**
19. **ssm parameter resource 2**
20. **ssm parameter resource 3**
21. **ssm parameter resource 4**
22. **ssm parameter resource 5**
23. **ec2**






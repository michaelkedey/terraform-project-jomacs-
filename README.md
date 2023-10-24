# AWS Terraform Project (Jomacs)
## Author: michael_kedey
### Date: 19/10/2023
#### Last_modified: 24/10/2023
1. **Github: https://github.com/michaelkedey**
2. **Linkedin: https://www.linkedin.com/in/michaelkedey**


this is a cloud project which involves provissioning AWS resources via terraform and git actions.

1. Project structure
I have a **src** directory and **README.MD** file in the repo.
**terraform-project-jomacs-**

2. The src directory serves as the root of the project. It contains a **main.tf** file in which I created resources from modules already deffined. It also has other configurations as needed.
**terraform-project-jomacs-/src**

3. I have another directory called **modules** in **src** which contains reusable modules 
**terraform-project-jomacs-/src/modules**

4. Inside the **modules** directory,  I have 2 sub-directories which define 2 seperate reusable modules, **vpc** and **ec2**. In these sperate module directories, I deffined the components and resources perculiar to each.
**terraform-project-jomacs-/src/modules/vpc**
**terraform-project-jomacs-/src/modules/ec2**

5. The **vpc** module conatins all configurations for the vpc resource, **the main vpc.tf file, viraibles deffinnition (var.tf), outputs (outputs.tf), providers configuration (providers.tf), and a store.tf file which passes neceasry values to the ssm parameter store.**

6. The **Ec2** module also contains all configurations for the instance, the main **ec2.tf file, viraibles deffinnition (var.tf), outputs (outputs.tf), providers configuration (providers.tf), and a data.tf file where I defined a data resource for my ami.**

7. I have a vpc with 3 subnets; two public subnets in two different avaliabilty zones, and a private subnet which contains my instanace.

8. I also have a load balancer and a listener, associated in the public subnet, which distributes traffic to the security group in which the instance resdides.

9. I have an Internet Gateway in the vpc which has a public route table, with routes deffined which send all traffic to the internet. 

10. I also have a NAT Gateway residing in the public subnet, which has a route table with a route diffined which sends outbount traffic from the private subnet through the NAT Gateway.

11. I have different security groups for the ec2 and the load balancer
12. I have an Ec2 instance, with a shell script which runs at boot time

13. To deploy this infrasrcture, clone the repository to your local environment
14. move into the cloned repository, ceate a branch and switch to it
15. change directory into the src directory, which contains the **main.tf** file
16. Run terraform init, to initialize the appropriate terraform 
17. I have also automated the deployment of the infrastracture by including a **.github/workflows directory in my root directory, in which i deffined an action.yml file**

18. **If you clone the repo, and push to github sometime, remeber to take out or modify the actions.yml file**








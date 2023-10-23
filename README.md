# terraform-project-jomacs-

# terraform-project-jomacs-
Author: michael_kedey
Date: 19/10/2023
Last_modified: 23/10/2023
Github: https://github.com/michaelkedey
Linkedin: https://www.linkedin.com/in/michaelkedey


this is a cloud project which involves provissioning AWS resources via terraform and git actions.

#Project structure
I have a src directory and README.MD file in the repo.
terraform-project-jomacs-

The src directory serves as the root of the project. It contains a main.tf file in which I created resources from modules already deffined. It also has other configurations as needed.
terraform-project-jomacs-/src

I have aother directory called modules in src which contains reusable modules 
terraform-project-jomacs-/src/modules

Inside modules I have 2 more directories which define 2 seperate reusable modules, vpc and ec2. In these sperate module directories, I deffined the components and resources perculiar to each.
terraform-project-jomacs-/src/modules/vpc
terraform-project-jomacs-/src/modules/ec2









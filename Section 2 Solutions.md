### Section 2: Hands-on Practical Assignments



##### Task 1: Create a Custom VPC with Public & Private Subnets
* Create a VPC with CIDR block 10.0.0.0/16.
* Define two subnets:
    * Public Subnet: 10.0.1.0/24, allows outbound internet access.
    * Private Subnet: 10.0.2.0/24, restricted from direct internet access.
* Attach an Internet Gateway to the VPC and associate it with the public subnet.
* Define routing tables for both subnets.

Solutions is [Here](https://github.com/StasX/TerraformExam/tree/main/Task_1)

##### Task 2: Deploy an EC2 Instance in the Public Subnet
* Launch an EC2 instance with the following specifications:
    * AMI: Ubuntu 22.04
    * Instance Type: t2.micro
    * Assign a public IP address
    * Security Group: Allow SSH (port 22) and HTTP (port 80)
* Use Terraform outputs to display the public IP of the instance.

Solutions is [Here](https://github.com/StasX/TerraformExam/tree/main/Task_2)

##### Task 3: Convert the VPC and EC2 Configuration into a Terraform Module
* Refactor the VPC and EC2 configuration into a reusable module.
* The module should allow users to specify:
    * VPC CIDR range
    * Subnet count
    > I assume that all subnets are public and have one instance
    * Instance type
    * Whether a public IP should be assigned
* Deploy the module in a separate Terraform root configuration.
> I assume that all instances have to be located in one availability zone
Solutions is [Here](https://github.com/StasX/TerraformExam/tree/main/Task_3)

##### Task 4: Deploy an Application Load Balancer with Auto Scaling
* Create an Application Load Balancer (ALB).
* Attach a target group and add the EC2 instances.
* Configure auto-scaling with a minimum of 1 and a maximum of 3 instances.
* Use Terraform outputs to display the ALB DNS name.
> I assume that region have 4 availability zones

Solutions is [Here](https://github.com/StasX/TerraformExam/tree/main/Task_4)

### Section 1: Q&A (20 Questions)



* #### Terraform Fundamentals (5 questions)


    * What is Terraform and how does it differ from other IaC tools?
    > terraform is a cloud-agnostic tool using code to provision infrastructure across multiple providers (VPS providers too)
    * Explain Terraform's declarative nature and state management.
    > terraform is declarative: you define the "end state," and it handles the "how." State management mapping the code to real resources, tracking changes and ensuring your infrastructure stays synced with your state.
    * What is the purpose of the Terraform provider?
    > terraform provider is an plugin that connect between Terraform and specific cloud API.
    * How does Terraform handle dependency resolution?
    > terraform  uses implicit dependencies from resource references and explicit dependencies trough __*depends_on*__ argument.
    * What are the key components of a Terraform configuration file?
    > providers (plugins)
    >  resources (infrastructure objects)
    > variables (inputs)
    > and outputs (return values)
    > modules (container for resources)

* ##### State Management & Backend Configuration (3 questions)


    * Explain the difference between *terraform refresh*, *terraform plan*, and *terraform apply*.  
    > terraform refresh updates state file.   
    > terraform plan generating preview.  
    > terraform apply deploying...  

    * What is the difference between local and remote backends?
    > local backend means currant machine and remote backend mean to remote server that u deploying it

    * How can you prevent state corruption when multiple engineers work on the same infrastructure?
    > when you put it on S3 you have to use DynamoDB to manage the lock 

* ##### Terraform Modules & Reusability (4 questions)


    * What are the benefits of using Terraform modules?
    > modules are reusable and making maintenance easier

    * Explain how to pass variables to a Terraform module.
    > you have to define variables in module and pass them from module declaration in root
        *first create a variables in a module:*
            # modules/some_module/variables.tf

            variable "name" {
                type = string
            }

        *than pass values from root:*
            module "some_module" {
                source = "./modules/some_module"
                name = "abc"
            }
        
        *now you can use passed value in module:*
            resource "aws_vpc" "main_vpc" {
                cidr_block = "10.0.0.0/16"
                tags = {
                    Name = var.name
                }
            }


    * What is the difference between count and for_each?
    > __*count*__ creates resources based on a number and indexes them by position , while __*for_each*__ creates resources from a map or set and indexes them by unique keys
    
    * How do you source a module from a Git repository?
    > you just need to use path to git repo in module source:
    
        module "some_module" {  
            source = "git@github.com:username/repo.git?ref=v1.0.0"  
                # ...  
        } 

* ##### Terraform with AWS (4 questions)


    * How do you create an EC2 instance with Terraform?
    > define an aws_instance resource in a .tf file, specifying the AMI and instance type, then run terraform plan and then terraform apply.
        
        resource "aws_instance" "example" {
            ami           = "ami-0c55b159cbfafe1f0"
            instance_type = "t2.micro"
        }
        
    * What are the required fields for defining a VPC in Terraform?
    > cidr_block
    * Explain how Terraform manages IAM policies in AWS.
    > it defining them as JSON-like code and linking them to identities using attachment resources to automate access control.
    * How do you use Terraform to provision and attach an Elastic Load Balancer?
    >   
        1. define aws_lb
        2. define aws_lb_target_group
        3. define aws_lb_listener
        4. attach instances trough aws_lb_target_group_attachment

* ##### Debugging & Error Handling (4 questions)


    * What does the terraform validate command do?
    > it find syntax errors and internal internal inconsistencies
    * How can you debug Terraform errors effectively?
    > set TF_LOG=DEBUG, then use terraform plan to catch logic issues and then inspect the state file
    * What is Terraform’s ignore_changes lifecycle policy used for?
    > it prevents terraform from updating specific resource attributes during an apply
    * How do you import existing AWS infrastructure into Terraform?
    >
        1. add an import block
        2. run command __*terraform plan -generate-config-out=generated.tf*__
        3. _generated.tf_ will contain imported configuration 


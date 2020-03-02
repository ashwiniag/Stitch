Stitch
An attempt to deploy services in fargate and adapt CI/CD flow.
Agenda: To learn Cloudformation, AWS resources, architecture setup, CI/CD flow, microservices test cases
and to jot down entire picture in books and blogs.

# Infrastructure setup

Used: cloudformation 
**vpc.yml**
- Private VPC for hosting of aws services, microservices, dbinstances.
- It creates 2 public subnets and 2 private subnets. 
Imp!:: Have a dedicated NAt gateways for each private subnets.
    :: Always keep extra range of ip availaible for future case. We might up endup exhausting 
       exsisting ip and then run out for private dbs/private ec2 ... Thus keep Calculate
       subnets wisely and keep it handy need not create at once but only when needed.
    :: Have dedicated subnets DB servers, containerized/webapplication which will run in private ip, also public subnets for jump servers/nat/other applications.
- Association of respective route tables and its routes.
Note: 
- For better subnet understanding and its calculation refer http://www.davidc.net/sites/default/subnets/subnets.html?network=10.0.0.0&mask=19&division=1.0

**securitygroup**
- Dedicated security group for each service that palys part in hosting services. 
- This layer just creates security group for only alb and other such services which are launched once and are not touched for good time. 

**alb.yml**
- I have a Public ALB. It listens on two ports 
a. 80 port: which is by default redirected to 443. (http request --https)
b. 443 port: where an option to attach multiple listener rules at this port for conditioned based request routing 
here apply certificate..ssl/tls
I have created dedicated alb.yml file because we dont often play much with alb. And its one time creation. 
All other applications will be running behind ALB to communicate with the world.
- Attaches security group created in previous layer. 

**fargateservices.yml**
- Yes I agree naming convention can be lot better and folder structure. I kinda little ran out of time.
- This layer will create:
a. An alb target group (objects)
b. dedicated security group
c. Fargate: cluster, services, container definition, roles and their attachment. Rolling update.
- his topic is pretty interesting. Soon will be posting blog posts on it.
Why I have created these AWS resources here? lets say I have created HAllo-World service its neccessary resources 
which are important and are required, tomorrow when I delete them...I dont want these resources dangling around like nomads.
HEnce Respective service will be deleted along with their colleagues. Easy to maintain.

**hello-ktor**
Soon enough Ill be updating this folder structure for easy maintainence and deployment.
At present its just web app displaying hello world !

**Dockerfile**
Simple comands just to dockerize webapplication

**shellscrip*t*
In general there are three stages involved 
a. build the application locally run respective test cases
b. dockerize it using docker file and renaming docker images based on snvironment
c. normal health check after starting containers from created docker images.
Yeah can come up with more insights or ideas too:)

# CICD:
As beginner I have used Codebuild and codepipleine...at first to understand the flow and get an idea.
FLow is simple: 
*--> githb --> codepipline (take the latest commit)--> codebuild (runs shellscript)--> build artifact and store in S3, also
build docker image and stores in ECR repo--> dump* 
well it understands what to do is from YML file

AWS resources used.
- ECR Repository: To store docker image and deploying into ECS fargate
- S3 Bucket: To store artifacts
- IAM Role for CodePipeline Execution
- IAM Role for CodeBuild Execution
- IAM Role for Cloudformation Execution
- AWS Codebuild
- AWS CodePipeline

# USE:
- git clone
- Use Cloudformation CLI to create and play around. **AWS::StackName** value i.e stack name is used as basic distinction

#ToDO:
Alert! Sanitization needed and Lots TODO.
[] Make it parameterised for creation of AWS resources for different environments
[] More roubust and better choice of nomenclature
[] For CICD deployment store commit sha and its details to have every details.
[] Fargate deployement based on tag.
[] Monitoring??
[] Restructure the folder structure
[] shellscript to populate folder structure according to requirements and easy use of CF CLI 
[] an order of creation of AWs resources and more controlled thought.

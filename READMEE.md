Infrastructure setup
    ECS Cluster
    VPC
    2 Subnets
    RouteTable
    Route
    2 SubnetRouteTableAssociations
    InternetGateway
    VPCGatewayAttachment
    IAM Role for ECS Task Execution
    ECS TaskDefinition
    2 SecurityGroups
    LoadBalancer
    TargetGroup
    Listener
    ECS Service
CI/CD
AWS resources used.
- ECR Repository: To store docker image and deploying into ECS fargate
- S3 Bucket: To store artifacts
- IAM Role for CodePipeline Execution
- IAM Role for CodeBuild Execution
- IAM Role for Cloudformation Execution
- AWS Codebuild
- AWS CodePipeline
Use
Contribution

Errors

_24023f74551e8928af5f95fa6be3f9bf.vhzmpjdqfx.acm-validations.aws.Up
An error occurred (InsufficientCapabilitiesException) when calling the CreateStack operation: Requires capabilities : [CAPABILITY_NAMED_IAM]

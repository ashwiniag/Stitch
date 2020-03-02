
Infrastructure setup
- VPC 

CI/CD

AWS resources used.
- ECR Repository: To store docker image and deploying into ECS fargate
- S3 Bucket: To store artifacts
- IAM Role for CodePipeline Execution
- IAM Role for CodeBuild Execution
- IAM Role for Cloudformation Execution
- AWS Codebuild
- AWS CodePipeline

ToDO:
Alert! Sanitization needed
[] Make it parameterised for creation of AWS resources for different environments
[] More roubust and better choice of nomenclature
[] For CICD deployment store commit sha and its details to have every details.
[] Fargate deployement based on tag.
[] Monitoring??
[] Restructure the folder structure
[] shellscript to populate folder structure according to requirements and easy use of CF CLI 


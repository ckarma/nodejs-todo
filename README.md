To set up a CI/CD pipeline for a Node.js application using GitHub Actions, Docker, and deploying into an AWS ECS cluster, following best practices for highly available, secure, and optimize cost. This guide will also cover the creation of infrastructure using Terraform, Dockerfile creation, GitHub Actions configuration, secret management, code quality checks, deployment to ECS and setting up CloudWatch monitoring.

Step 1: Infrastructure Setup with Terraform

First, we need to create the necessary AWS resources using Terraform. This includes creating an ECS cluster, VPC, subnets, security groups, and IAM roles for ECS tasks.

#main.tf

To run this example you need to execute:

  $ terraform init

  $ terraform plan

  $ terraform apply
  

Step 2: Dockerfile Creation

Create a Dockerfile in the root of your Node.js application directory. This file will define how to build your Docker image.

#Dockerfile

Step 3: GitHub Actions Configuration

This file will define the CI/CD pipeline stages including building the Docker image, running tests, and deploying to ECS.

Create a aws.yml file.

Folder path: .github/workflows

Step 4: Managing Secrets

GitHub Secrets should be used to securely store sensitive information such as AWS credentials, Docker registry details, etc. These secrets can be added in the repository settings under the "Secrets" section.

Add the following secrets to your GitHub repository: AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, DOCKER_USERNAME, DOCKER_PASSWORD

Step 5: Deploying to ECS and Setting Up CloudWatch Monitoring

The deployment to ECS is configured in the GitHub Actions workflow. For CloudWatch monitoring, ensure that your ECS tasks are configured to send logs to CloudWatch Logs. Then, create CloudWatch Alarms based on metrics to notify the issues.

Enable CloudWatch Monitoring for EC2 Instances :

Log in to AWS Management Console. Navigate to EC2: Go to the EC2 Dashboard. Select Instances: Choose the instances you want to monitor.

Actions > Monitor and Troubleshoot > Manage CloudWatch Alarms: Configure basic CloudWatch metrics for EC2 instances.

Create CloudWatch Dashboards :

Go to CloudWatch: Open the CloudWatch console. Dashboards: Click on "Dashboards" in the left-hand menu. Click “Create dashboard”: Enter a name for your dashboard.

Add Widgets: You can add different types of widgets (e.g., graphs, numbers, text) to visualize various metrics. 
Add Graphs: Choose “Add widget”, select “Line” or “Stacked area” graph to visualize metrics like CPU utilization, disk I/O, etc. 
Add Numbers: Show metrics like average response time or error rates.

Configure Widgets: Select metrics from your AWS resources (EC2, RDS, Lambda, etc.) and customize the display settings. After configuring the widgets, click “Save changes” to save the dashboard.

Set Up CloudWatch Alarms :

Open CloudWatch Console. Here’s a setting of a CloudWatch alarm for high CPU utilization: Metric: Select EC2 and then Per-Instance Metrics.

Metric Name: Choose CPU Utilization. Conditions: Set “Threshold type” to “Static” and “Whenever CPU Utilization is” greater than 80.

Actions: Choose to send a notification to an SNS topic.

Go to the SNS console. Click “Create topic” and choose “Standard” as the type. Provide a name and configure subscriptions (e.g., email).

Attach SNS Topic: Use the SNS topic ARN in your CloudWatch alarm action settings. Save and Review.

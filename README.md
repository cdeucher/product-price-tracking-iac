### About this repository:
The objective of this project is to create an application where you can subscribe with an email,
link to a AWS product page and price target. 
If the price of the product drops below the price target, you will receive an email notification with the new price.

To make this possible, we will use the following AWS services:
- AWS API Gateway
- AWS Lambda
- AWS DynamoDB
- AWS Route53
- AWS SNS
- AWS CloudWatch
- AWS S3
- AWS Step Functions
- AWS IAM
- AWS Certificate Manager
- AWS Cognito

### Serverless architecture for AWS Lambda and AWS API Gateway

This repository contains the IaC and Functions for the [java-selenium-aws-api-gateway-rest](https://github.com/cdeucher/java-selenium-aws-api-gateway-rest) project.


### How it works
1º) The user sends a request to the API Gateway endpoint with the URL of the website to be tested as a parameter.

2º) AWS API Gateway will invoke the AWS Lambda function and store the result in the DynamoDB table.

3º) DynamoDB stream will trigger the AWS Lambda function to filter the results.

4º) Cognito will authenticate the request before triggering the AWS Lambda function.

### To be done
- User create account with Google to authenticate with Cognito.
- User will receive an email with the results of the test.
- Enable CORs in the API Gateway.
- Lambda function should use layers to reduce the size of the deployment package.
- Cron to run the Lambda function every 24 hours and compare the results with the DynamoDB table.
- Page to subscribe with email, URL and price target.


## Deployment
- Customize the Terraform code to your needs in the `/environments/` directory:
```HCL
  accountId = "accountId from AWS IAM, ex. (123498234)"
  domain    = "domain name of the hosted zone, ex. (example.com)"
```

```bash
$ terraform init
$ terraform plan -out plan.tfplan
$ terraform apply plan.tfplan
```

### Testing the API without Cognito

```bash
curl -XPOST 'https://<custom dns>/<endpoint>' \
-d  '[{"text": "mushoku","price":"20.01","symbol":"R$","url":"localhost","type":"kindle"}]'

curl -XPOST 'https://d1sx0y9lgg.execute-api.us-east-1.amazonaws.com/dev/api2' \
-d  '[{"text": "mushoku","price":"20.01","symbol":"R$","url":"localhost","type":"kindle"}]' \
-H 'Content-Type: application/json' -H "Authorization: 123"
```


### Testing the API with Cognito

### Create cognito user
```bash
./create_user.sh "<put your client id here>" "<put your user pool id here>" "<put a username>" "<put a password>"
```

### Get cognito token
```bash
./get_token.sh "<put your client id here>" "<put a username>" "<put a password>"
```

### Test the API
```bash
./api_test.sh "<api-url>" "<token>"
```

```bash
curl -XPOST 'https://api-dev.<dns>/titles' \
-d  '[{"text": "mushoku","price":"20.01","symbol":"R$","url":"localhost","type":"kindle"}]' \
-H 'Content-Type: application/json' -H "Authorization:${TOKEN}"

curl -XPOST 'https://api-gateway.../v1/titles' \
-d  '[{"text": "mushoku","price":"20.01","symbol":"R$","url":"localhost","type":"kindle"}]' \
-H 'Content-Type: application/json' -H "Authorization:${TOKEN}"
```

### based on [cognito-authorizer-using-terraform](https://hands-on.cloud/managing-amazon-api-gateway-using-terraform/#h-cognito-authorizer-using-terraform)
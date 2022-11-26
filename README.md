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
- Page to subscribe with email, URL and price target.

## Pre-requisites
- Domain registered in Route53

## Deployment
- Customize the Terraform code to your needs in the `/environments/` directory:
```HCL
  accountId = "accountId from AWS IAM, ex. (123498234)"
  domain    = "domain name of the hosted zone, ex. (example.com)"
```
- Export the GCP credentials to the environment:
  - Check out for more information: [how-to-add-google-social-sign](https://beabetterdev.com/2021/08/16/how-to-add-google-social-sign-on-to-your-amazon-cognito-user-pool)
```bash
export GCP_CLIENT_ID="xxxx.apps.googleusercontent.com"
export GCP_CLIENT_SECRET="xxxx-O0uiHAWoT00cKlNrxxx"
```

```bash
$ terraform init
$ terraform apply --var-file=environments/dev.tfvars \
  -var="gcp_client_id=${GCP_CLIENT_ID}" \ 
  -var="gcp_client_secret=${GCP_CLIENT_SECRET}"
```

### Testing the API without Cognito

```bash
curl -XPOST 'https://<custom dns>/<endpoint>' \
-d  '[{"text": "mushoku","price":"20.01","symbol":"R$","url":"localhost","type":"kindle"}]'

curl -XPOST 'https://ou02gqjcek.execute-api.us-east-1.amazonaws.com/dev/api2' \
-d  '[{"text": "mushoku","price":"20.01","symbol":"R$","url":"localhost","type":"kindle"}]'
```


### Testing the API with Cognito

### Create cognito user
```bash
./create_user.sh "<put your client id here>" "<put your user pool id here>" "<put a username>" "<put a password>"

 # aws cognito-idp sign-up --client-id xuxnxk0jqoaxxklmxxxp7itxsx --username admin --password Admin@123
```

### Get cognito token
```bash
./get_token.sh "<put your client id here>" "<put a username>" "<put a password>"

# TOKEN=$(./get_token.sh xuxnxk0jqoaxxklmxxxp7itxsx admin ExamplePass@123)
```

### Test the API
```bash
./api_test.sh "<api-url>" "<token>"

# ./api_test.sh "https://api-dev.cabd.link/api2" "${TOKEN}"
```

```bash
curl -XPOST 'https://api-dev.<dns>/titles' \
-d  '[{"text": "mushoku","price":"20.01","symbol":"R$","url":"localhost","type":"kindle"}]' \
-H 'Content-Type: application/json' -H "Authorization:${TOKEN}"

curl -XPOST 'https://api-gateway.../v1/titles' \
-d  '[{"text": "mushoku","price":"20.01","symbol":"R$","url":"localhost","type":"kindle"}]' \
-H 'Content-Type: application/json' -H "Authorization:${TOKEN}"
```
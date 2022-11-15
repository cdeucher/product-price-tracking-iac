### Serverless architecture for AWS Lambda and AWS API Gateway

This repository contains the IaC and Functions for the [java-selenium-aws-api-gateway-rest](https://github.com/cdeucher/java-selenium-aws-api-gateway-rest) project.


### How it works
1º) The user sends a request to the API Gateway endpoint with the URL of the website to be tested as a parameter.

2º) AWS API Gateway will invoke the AWS Lambda function and store the result in the DynamoDB table.

3º) DynamoDB stream will trigger the AWS Lambda function to filter the results.

4º) Cognito will authenticate the request before triggering the AWS Lambda function.

### To be done
- The user will receive an email with the results of the test.
- Enable CORs in the API Gateway.
- Lambda function should use layers to reduce the size of the deployment package.


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

### Testing the API

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
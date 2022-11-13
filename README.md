### Serverless architecture for AWS Lambda and AWS API Gateway

This repository contains the IaC and Functions for the [java-selenium-aws-api-gateway-rest](https://github.com/cdeucher/java-selenium-aws-api-gateway-rest) project.


### How it works
1º) The user sends a request to the API Gateway endpoint with the URL of the website to be tested as a parameter.

2º) The AWS API Gateway will invoke the AWS Lambda function and store the result in the DynamoDB table.

3º) (not finished) The DynamoDB stream will trigger the AWS Lambda function to filter the results and send an email with the results.


### Testing the API

```bash
curl -XPOST 'https://api-dev.<dns>/titles' \
-d  '[{"text": "mushoku","price":"20.01","symbol":"R$","url":"localhost","type":"kindle"}]' \
-H 'Content-Type: application/json'

curl -XPOST 'https://api-gateway.../v1/titles' \
-d  '[{"text": "mushoku","price":"20.01","symbol":"R$","url":"localhost","type":"kindle"}]' \
-H 'Content-Type: application/json'
```
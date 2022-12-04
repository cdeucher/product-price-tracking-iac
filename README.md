### About this repository:
- IaC to deploy a full stack application on AWS using Terraform.
- Check out the [terraform-infra](terraform-infra/README.md) repository to see the code and requirements.

### About the Application
The application allows you to subscribe to an AWS product and price target.
If the product's price drops below the target, you will receive an email notification with the new price.


### How it works
1º) The user sends a request to the API Gateway endpoint with the URL of the website to be tested as a parameter.

2º) AWS API Gateway will invoke the AWS Lambda function and store the result in the DynamoDB table.

3º) DynamoDB stream will trigger the AWS Lambda function to filter the results.

4º) Cognito will authenticate the request before triggering the AWS Lambda function.

### To be done
- `done` - User create account with Google to authenticate with Cognito.
- User will receive an email with the results of the test.
- Enable CORs in the API Gateway.
- Lambda function should use layers to reduce the size of the deployment package.
- Page to subscribe with email, URL and price target.


### Testing the API with Cognito
- Check out the [README-TEST.md](README-TEST.md) file to see how to test the API with Cognito.

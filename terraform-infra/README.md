## IAC - Terraform

## This repository will create the following resources:
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
- AWS CloudFront

## Requirements
- Route53 zone with at least one domain name hosted on it:
  - [AWS Zone](https://aws.amazon.com/route53/pricing/zone-pricing/)
- GCP Auth Credentials to Federate with Cognito:
    - Check out for more information: [how-to-add-google-social-sign](https://beabetterdev.com/2021/08/16/how-to-add-google-social-sign-on-to-your-amazon-cognito-user-pool)
    - Create a new project in the [Google Cloud Platform](https://console.cloud.google.com/)
    - After applying to terraform code, its necessary to authorize Cognito domain on Google Cloud Platform
        - URL to authorize the Google account: https://<cognito-pool>.auth.<region>.amazoncognito.com/oauth2/idpresponse

## How to use
Customize the Terraform code to your needs in the `/environments/` directory:
```HCL
  accountId = "accountId from AWS IAM, ex. (123498234)"
  domain    = "domain name of the hosted zone, ex. (example.com)"
  gcp_client_id = "xxxx.apps.googleusercontent.com"
  gcp_client_secret = "xxxx-O0uiHAWoT00cKlNrxxx"
  service_account_ci_arn = "service account arn, could be found in the AWS IAM"
  accountId = "accountId from AWS IAM, ex. (123498234)"
  domain = "domain name of the hosted zone, ex. (example.com)"
  # Grafana : https://grafana.com/docs/grafana-cloud/data-configuration/integrations/integration-reference/integration-cloudwatch/
  grafana_account_id = "xxxx"
  external_id       = "xxxx"
```

```bash
$ # terraform init - in this case, its necessary remove `backend` block from `provider.tf` file
$ terraform init -backend-config="backend.hcl" # check the backend.hcl file and customize it to your needs
$ terraform workspace select dev
$ terraform apply --var-file=environments/dev.tfvars \
  -var="gcp_client_id=${GCP_CLIENT_ID}" \ 
  -var="gcp_client_secret=${GCP_CLIENT_SECRET}" \
  -var="service_account_ci_arn=${SERVICE_ACCOUNT_CI_ARN}" \
  -var="accountId=${ACCOUNT_ID}" \
  -var="grafana_account_id=${GRAFANA_ACCOUNT_ID}" \
  -var="grafana_external_id=${GRAFANA_EXTERNAL_ID}" \
  -var="domain=${DOMAIN}" \
  -out plan.tfplan
$ terraform apply plan.tfplan
```

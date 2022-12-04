
## Testing the API without Cognito
- Update the `authorizer_cognito_enabled` variable to `false` in the `terraform-infra/environments/dev.tfvars` file.

```bash
curl -XPOST 'https://<custom dns>/<endpoint>' \
-d  '[{"text": "mushoku","price":"20.01","symbol":"R$","url":"localhost","type":"kindle"}]'

curl -XPOST 'https://ou02gqjcek.execute-api.us-east-1.amazonaws.com/dev/api2' \
-d  '[{"text": "mushoku","price":"20.01","symbol":"R$","url":"localhost","type":"kindle"}]'
```

## Testing the API with Cognito
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
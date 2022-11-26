import os
import boto3
import json
import logging
import jwt
from datetime import datetime;

logger = logging.getLogger()
logger.setLevel(logging.INFO)

dynamodb_client = boto3.client('dynamodb')

TITLES_TABLE = os.environ.get('TITLES_TABLE', 'titles')

def handle(event, context):
    logger.info("Request: %s", event)
    response_body = {'error': 'Unprocessable Entity'}
    response_code = 422
    body = event.get('body')
    headers = event.get('headers')
    logger.info("Headers: %s", headers)
    #logger.info("Authorization: %s", headers['Authorization'])
    try:
        # decodedToken = jwt.decode(headers['Authorization'], algorithms=["RS256"], options={"verify_signature": False})
        if validate_fields(json.loads(body)):
            list_titles = json.loads(body)
            for title in list_titles:
                save_title(title)
            response_body = {'list': 'ok', 'count': list_titles.__len__() } #, 'username': decodedToken["cognito:username"]}
            response_code = 200
    except Exception as e:
        logger.error("Error: %s", e)

    response = {
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
        },
        'statusCode': response_code,
        'body': json.dumps(response_body)
    }

    logger.info("Response: %s", response)
    return response

def save_title(title):
    if not os.environ.get('IS_OFFLINE'):
        date_now = datetime.now().strftime("%d/%m/%Y %H:%M:%S")
        dynamodb_client.put_item(
            TableName=TITLES_TABLE,
            Item={
                'text': {'S': title['text']},
                'price': {'S': title['price']},
                'symbol': {'S': title['symbol']},
                'url': {'S': title['url']},
                'type': {'S': title['type']},
                'date': {'S': date_now}
            }
        )
    #if os.environ.get('IS_OFFLINE'):
    #    dynamodb_client = boto3.client(
    #        'dynamodb', region_name='localhost', endpoint_url='http://localhost:8000'
    #   )
    return True

def validate_fields(body_elements):
    print(body_elements)
    if type(body_elements) is not list:
        return False

    list_fields = ['text', 'price', 'symbol', 'url', 'type']

    for elements in body_elements:
        for key in elements:
            if key not in list_fields:
                return False
    return True

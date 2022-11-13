import os
import boto3
import json
import logging
from datetime import datetime;

logger = logging.getLogger()
logger.setLevel(logging.INFO)

dynamodb_client = boto3.client('dynamodb')

TITLES_TABLE = os.environ.get('TITLES_TABLE', 'titles')

def handle_addtitle(event, context):
    logger.info("Request: %s", event)
    response_body = {'error': 'Unprocessable Entity'}
    response_code = 422
    body = event.get('body')

    if validate_fields(json.loads(body)):
        list_titles = json.loads(body)
        for title in list_titles:
            save_title(title)
        response_body = {'list': 'ok', 'count': list_titles.__len__()}
        response_code = 200

    response = {
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

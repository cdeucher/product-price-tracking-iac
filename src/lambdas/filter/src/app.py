import os
import boto3
import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def handle(event, context):
    logger.info("handle %s", event)
    response_body = {'ok': 'Entity'}
    response_code = 200

    response = {
        'statusCode': response_code,
        'body': json.dumps(response_body)
    }

    logger.info("Response: %s", response)
    return response


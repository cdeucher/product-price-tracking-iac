import os
import boto3
import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def handle(event, context):
    logger.info("exec_filter %s", event)
    response_body = {'error': 'Unprocessable Entity'}
    response_code = 422

    if validate_fields(event):
        for record in event['Records']:
            logger.info("record %s %s", record['eventID'], record['eventName'])

        response_code = 200
        response_body = callback()

    response = {
        'statusCode': response_code,
        'body': json.dumps(response_body)
    }

    logger.info("Response: %s", response)
    return response


def callback():
    response_body = {'message': 'Hello, World!'}
    logger.info("Response: %s", response_body)
    return response_body


def validate_fields(events_elements):
    logger.info("exec_filter %s %s", events_elements, type(events_elements))
    if type(events_elements) is not dict:
        return False
    if 'Records' not in events_elements:
        return False
    if type(events_elements['Records']) is not list or len(events_elements['Records']) == 0:
        return False

    list_fields = ['eventID', 'eventName']

    for elements in events_elements['Records']:
        logger.info("elements %s", elements)
        for key in elements:
            if key not in list_fields:
                return False
    return True

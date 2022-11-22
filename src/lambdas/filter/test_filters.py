import filter
import pytest
import simplejson as json

def test_exec_filter():
    event = dict(Records=[{"eventID": "1", "eventName": "test"}])
    context = None
    response = filter.exec_filter(event, context)
    assert response['statusCode'] == 200

def test_exec_filter_empty():
    event = dict(Records=[])
    context = None
    response = filter.exec_filter(event, context)
    assert response['statusCode'] == 422

def test_exec_filter_none():
    event = None
    context = None
    response = filter.exec_filter(event, context)
    assert response['statusCode'] == 422

def test_exec_filter_empty_string():
    event = {
        'body': ''
    }
    context = None
    response = filter.exec_filter(event, context)
    assert response['statusCode'] == 422


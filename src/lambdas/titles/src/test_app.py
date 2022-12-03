import titles
import pytest
import simplejson as json

def test_handle_addtitle():
    # python -c 'import jwt; print("%s",jwt.encode({"cognito:username": "payload"}, "secret", algorithm="HS256"))'
    event = {
        'body': '[{"text": "test", "price": "test", "symbol": "test", "url": "test", "type": "test"}]',
        'headers': {'Authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb2duaXRvOnVzZXJuYW1lIjoicGF5bG9hZCJ9.A5GnRt0s-ielX_WdF7HJMaEVUsAjN3LGQzgZnh-nMBM'}
    }
    context = None
    response = app.handle(event, context)
    assert response['statusCode'] == 200

def test_validate_fields():
    body = json.loads('[{"text": "test", "price": "test", "symbol": "test", "url": "test", "type": "test"}]')
    response = app.validate_fields(body)
    assert response == True

def test_validate_fields_empty():
    body = '{}'
    response = app.validate_fields(body)
    assert response == False

def test_validate_fields_none():
    body = None
    response = app.validate_fields(body)
    assert response == False

def test_validate_fields_empty_string():
    body = ''
    response = app.validate_fields(body)
    assert response == False

def test_validate_fields_string():
    body = 'test'
    response = app.validate_fields(body)
    assert response == False

def test_validate_fields_int():
    body = 1
    response = app.validate_fields(body)
    assert response == False

def test_validate_fields_float():
    body = 1.1
    response = app.validate_fields(body)
    assert response == False
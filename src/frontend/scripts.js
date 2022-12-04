var token = ''

function onSignIn() {
    console.log("login...");
    login();
}
function login() {
    token = get_token();
    if( token != null){
        console.log('logged in!');
    }else {
        client_id="2cct9b33ba202phg61fspdppho";
        cognito_domain="login-ze0zatn0ipkhxh56";
        region="us-east-1";
        redirect="https://dash.cabd.link";
        aws_cognito_login_domain="https://"+cognito_domain+".auth."+region+".amazoncognito.com";
        cognitoUrl_fromUserPoolUI=aws_cognito_login_domain+"/login?client_id="+client_id+"&response_type=token&scope=email+openid+phone&redirect_uri="+redirect;
        window.location.href = cognitoUrl_fromUserPoolUI;
    }
}
function get_token() {
    try {
        var token = window.location.href.split('=')[1].split('&')[0]
        console.log("token: " + token);
        return token;
    }catch (e) {
        return null;
    }
}

function sendRequest() {
    //send the request to the server
    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'https://api-dev.cabd.link/api2', true);
    xhr.setRequestHeader('Authorization', token);
    xhr.setRequestHeader('Content-Type','application/json');
    xhr.send('[{"text": "mushoku","price":"20.01","symbol":"R$","url":"localhost","type":"kindle"},{"text": "mushoku1","price":"20.01","symbol":"R$","url":"localhost","type":"kindle"}]');
    xhr.onload = function() {
        //if (this.status == 200) {
        //do something with the response
        console.log(this.responseText);
        //}
    }
    xhr.onerror = function() {
        //do something with the error
        console.log(this.responseText);
    }
}
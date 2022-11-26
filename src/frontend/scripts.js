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
        window.location.href = "https://login-6il81smzduwx5dhj.auth.us-east-1.amazoncognito.com/login?client_id=47hr08os7gvoa6ig3i82iqqd9e&response_type=token&scope=email+openid+phone&redirect_uri=https://dash.cabd.link";
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
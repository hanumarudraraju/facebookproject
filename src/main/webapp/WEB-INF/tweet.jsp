<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<style>
.sidenav {
height: 100%;
width: 205px;
position: fixed;
z-index: 1;
top: 0;
background-color: #013243;
overflow-x: hidden;
padding-top: 40px;
}

.sidenav a {
padding: 25px 8px 85px 30px;
font-family: 'Allerta', sans-serif;
font-size: 35px;
color: #D2CCA1;
display: block;
text-transform: uppercase;
}

.sidenav a:hover {
color: #f1f1f1;
}

.main {
    
    margin-left: 230px; /* Same as the width of the sidenav */
    font-size: 20px; /* Increased text to enable scrolling */
    padding: 0px 10px;
}


.home h1{
    text-align: center;
    font-family: 'Raleway', sans-serif;
    margin: 0;
    padding-top: 30px;

}

.home h4{
    font-family: 'Raleway', sans-serif;
    float: right;
    padding-right: 30px;
    padding-bottom: 20px;
}

</style>
<title>Tweeter Project Home page</title>
<div> <center> <h2 style="color:#D2CCA1;" id="fb-welcome"></h2> </center> </div> 
<br/> 




</head>
<div class="sidenav">
<a href="/tweet">Tweet</a>
<a href="/friendspage">Friend's Page</a>
<a href="/toptweets">Top Tweet</a>

</div>



<div class="main">
<div class="home">

<div> <center> <h3 style="color: #D2CCA1;" id="hdr">Tweet Page</h3> </center> </div>
<img id="img" src="">

<body>
<br>
<form action="tweet" method="post">
<input type="text" placeholder="write your Tweet here" name="my_text" style="width:100%;">
<input type="hidden" id="sndName" name="sndName" value=">" >
<br>
<br>
<center><input type="submit" value="Tweet It" style="width:200px; background-color: #013243; color: #D2CCA1; padding: 14px 30px; font-size: 20px; margin: 2px 1px; cursor: pointer;"></center>
<br>
<br>
</form>
<p id="confirmText"></p>

<center><select name="myselect" id="myselect" size="auto" >
</select></center>
<br>
<br>
<center><input class="button" type="button" value="Tweet information" id="my_btn3"  onclick="showTweet();" style="background-color: #013243; color: #D2CCA1;" /><br>

<input class="button" type="button" value="Post to Timeline" id="my_btn"  onclick="postToTimeLine();" style="background-color: #013243; color:#D2CCA1; " /><br>

<input class="button" type="button" value="Message a Friend" id="my_btn2"  onclick="SendtofbMessageFriend();" style="background-color: #013243; color: #D2CCA1;" /></center>

</div>
</div>
<script>
//var lnk = '${testsndName}';
//console.log(lnk);
//var usertweetsCount = '${usertweetsCount}';
//console.log(usertweetsCount);
var usertweets = '${usertweets}';
//console.log(usertweets);
var myselect = document.getElementById('myselect');
usertweets = usertweets.split("-----")
for (var i = 0; i < usertweets.length-1; i++) {
//console.log(usertweets[i]);
var opt = document.createElement('option');
opt.value = usertweets[i].split('--')[0];
opt.innerHTML = usertweets[i].split('--')[1];
myselect.appendChild(opt);
}

window.fbAsyncInit = function() {
FB.init({
appId : '596135907424926',
xfbml : true,
version : 'v3.0'
});

function onLogin(response) {
if (response.status == 'connected') {
FB.api('/me?fields=first_name,last_name,picture', function(data) {
var welcomeBlock = document.getElementById('fb-welcome');
welcomeBlock.innerHTML = 'Hello... ' + data.first_name+' '+ data.last_name;
var sndName= document.getElementById("sndName")
if (sndName){
console.log('The sender is ok ');
sndName.value = data.first_name+' '+ data.last_name
}else{
console.log('The sender is ok ');
}

var image = document.getElementById("img");
image.className = "class";
image.src = data.picture.data.url;

});

} else {
var welcomeBlock = document.getElementById('fb-welcome');
welcomeBlock.innerHTML = 'Cant get data ' + response.status + '!';
}
}

FB.getLoginStatus(function(response) {
// Check login status on load, and if the user is
// already logged in, go directly to the welcome message.
console.log('getLoginStatus .... ');

if (response.status == 'connected') {
console.log('connected .... ');
onLogin(response);
} else {
// Otherwise, show Login dialog first.
console.log('Not connected .... ');
FB.login(function(response) {
onLogin(response);
}, {
scope : 'user_friends, email, user_birthday'});
}
});

console.log('logPageView .... ');
FB.AppEvents.logPageView();

};

(function(d, s, id) {
var js, fjs = d.getElementsByTagName(s)[0];
if (d.getElementById(id)) {
return;
}
js = d.createElement(s);
js.id = id;
js.src = "//connect.facebook.net/en_US/sdk.js";
fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));


function postToTimeLine() {
console.log('Posting to TimeLine ');

var mt = myselect.options[myselect.selectedIndex].innerHTML;
var lnk = 'https://facebooktweet-204804.appspot.com/display_tweet?id=' + myselect.options[myselect.selectedIndex].value ;

FB.login(function() {
FB.api('/me/feed', 'post', {
message : lnk
});
document.getElementById('confirmText').innerHTML = 'Thanks for posting the message ' + mt;
}, {scope : 'publish_actions'});
}



function SendtofbMessageFriend() {

console.log('Posting a message to user,s friend()s .... ');
//var msg = document.getElementById('my_text').value;
var lnk = 'https://facebooktweet-204804.appspot.com/display_tweet?id=' + myselect.options[myselect.selectedIndex].value ;

//link : 'http://www.nytimes.com/interactive/2015/04/15/travel/europe-favorite-streets.html',
//link : lnk,
FB.ui({
app_id : '596135907424926',
method : 'send',
link : lnk,
});

}

function showTweet() {
window.open('https://facebooktweet-204804.appspot.com/display_tweet?id=' + myselect.options[myselect.selectedIndex].value 
, '_blank', 'toolbar=yes, location=yes, status=yes, menubar=yes, scrollbars=yes');
}

</script>
</body>
</html>


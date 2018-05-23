<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<style>
    div {
      background-color: #3B5998;
      width: 455px;
      border: 10px red;
      padding: 5px;
      margin: 5px;
    }
    
    .button {
    background-color: #E74C3C;
    border: none;
    color: white;
    padding: 10px 42px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    }
  </style>
<title>Top 10 Tweets</title>
<div> <center> <h2 style="color:white;"  id="fb-welcome"></h2> </center> </div>
<br/>

<table >
  <tr>
    <th class="button" ><a style="color:white;" id="tweetLink">Tweet</a></th>
    <th class="button" ><a style="color:white;" href="/friendspage">Friends Page</a></th> 
    <th class="button" ><a style="color:white;" href="/toptweets">Top Tweets</a></th>
  </tr>
</table>
<br/>
<div> <center> <h3 style="color:white;" id="hdr">TOP Tweets</h3> </center> </div> 


</head>
<body>
	<input type="hidden" id="sndName" name="sndName" value=">" >
	<br>
	<h2 id="tt"></h2>
	<br>
	<br>
	<br>
	

	 <script>
		var usertweets = '${usertweets}';
		//console.log(usertweets);
		usertweets = usertweets.split("-----")
		for (var i = 0; i < usertweets.length-1; i++) {
			console.log(usertweets[i]);
			console.log(document.getElementById('tt').innerHTML);
			document.getElementById('tt').innerHTML = document.getElementById('tt').innerHTML +usertweets[i].split('--')[0]+'  ->  '+usertweets[i].split('--')[1]+'<br>';
		}
		
	 window.fbAsyncInit = function() {
			FB.init({
				appId : '596135907424926',
				xfbml : true,
				version : 'v3.0'
			});

			function onLogin(response) {
				if (response.status == 'connected') {
					FB.api('/me?fields=first_name,last_name', function(data) {
						var welcomeBlock = document.getElementById('fb-welcome');
						welcomeBlock.innerHTML = 'Hello... ' + data.first_name+' '+ data.last_name;
					    document.getElementById("tweetLink").href="/tweet?sndName="+data.first_name+' '+ data.last_name; 
						var sndName= document.getElementById("sndName")
						if (sndName){
							console.log('The sender is ok ');
							sndName.value = data.first_name+' '+ data.last_name
						}else{
							console.log('The sender is ok ');
						}
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
						scope : 'user_friends, email, user_birthday'
					});
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

	</script>
</body>
</html>
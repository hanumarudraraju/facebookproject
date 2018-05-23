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

    
    }
  </style>

<title>facebook tweet page</title>
<div> <center> <h2 style="color:white;" id="fb-welcome"></h2> </center> </div>
<br/>











<div class="sidenav">
<a id="tweetLink">Tweet</a>
<a href="/friendspage">Friend's Page</a>
<a href="/toptweets">Top Tweet</a>

</div>



<div class="main">
<div class="home">




















<br/>
<div> <center> <h1 style="background-color: #013243; color: #D2CCA1;" id="hdr">Welcome To My New App</h1> </center> </div>

</div><div> <center> <h1 style=" color: #D2CCA1;" id="hdr">HomePage</h1> </center> </div>

</div>
</head>
<body>
	 <script>
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
						welcomeBlock.innerHTML = 'Hello, ' + data.first_name+' '+ data.last_name + ''+'<br/>'+"welcome to fb tweet ";
						
					    document.getElementById("tweetLink").href="/tweet?sndName="+data.first_name+' '+ data.last_name; 
					});

					/* FB.api('/me?fields=last_name', function(data) {
						var welcomeBlock = document
								.getElementById('fb-welcome');
						welcomeBlock.innerHTML = welcomeBlock.innerHTML
								+ '  last name= ' + data.last_name + '!';
					}); */

					/* FB.api('/me?fields=birthday', function(data) {
						var welcomeBlock = document
								.getElementById('fb-welcome');
						welcomeBlock.innerHTML = welcomeBlock.innerHTML
								+ '  Your Age is , '
								+ (2017 - parseInt(data.birthday.toString()
										.substring(6, 10))).toString() + '!';
					}); */

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


	 <!-- <div class="fb-like" data-share="true" data-width="450"	data-show-faces="true"></div> -->
</body>
</html>
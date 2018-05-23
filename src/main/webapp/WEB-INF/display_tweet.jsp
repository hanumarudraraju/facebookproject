<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Display Tweet</title>
<style>
    div {
      background-color: red;
      width: 1000px;
      border: 10px black;
      padding: 5px;
      margin: 5px;
    }
  </style>
<h1 id="hdr">Display Tweet page</h1> 
<br/>
<br/>
</head>
<body>
	<input type="hidden" id="sndName" name="sndName" value=">" >
	<div>
	<p>Tweet id:</p>
	<p id="ID"></p>
	<br>
	<p>Tweeted by:</p>
	<p id="sender"></p>
	<br>
	<p>Tweet Text:</p>
	<p id="msg"></p>
	<br>
	<p>Tweet Date:</p>
	<p id="msgDate"></p>
	<br>
	<p>No. of times visited:</p>
	<p id="visited"></p>
	<br>
	</div>

	 <script>
	 //console.log("Record Count = "+'${rCount}');
	 document.getElementById("ID").innerHTML='${ID}'
	 document.getElementById("sender").innerHTML='${sender}'
	 document.getElementById("msg").innerHTML='${msg}'
	 document.getElementById("msgDate").innerHTML='${msgDate}'
	 document.getElementById("visited").innerHTML='${visited}'
	</script>
</body>
</html>
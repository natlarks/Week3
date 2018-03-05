# ----Natalie Larkin-----
# ---Week 3 Assignment---

# Creates localhost website
New-Item C:\inetpub\wwwroot\index.html -type file
echo '<html>

	<form action="#">
		<h1>Hello Hackers!!! Enter your name!</h1>

		First name: <input id="t1" type="text" name="fname">
		<br>
		Last name: <input id="t2" type="text" name="lname">
		<br>
		<input id="upload" type="submit" value="Submit">
	</form>

</html>'  > C:\inetpub\wwwroot\index.html

# Opens up Internet Explorer to go to localhost
$ie = New-Object -Com "InternetExplorer.Application"
$ie.Navigate("localhost")
$ie.Visible = $true

# Populates the textboxes with script and submits the form
$doc = $ie.document
$doc.getElementById("t1").value = "<script>alert(1);</script>"
$doc.getElementById("t2").value = "<script>alert(1);</script>"
$ie.Document.getElementById("upload").Click() 
echo "Finished"

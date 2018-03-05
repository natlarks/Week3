# Overview
This week the focus of the class was how important coding was in the security world. The tool I wanted to recreate was Zed Attack Proxy (ZAP), and Open Source tool that automatically tests for vulnerabilites in web applications. ZAP is mostly written in Java, so I wanted to try and recreate a part of it with a Powershell script. My example creates a website for you in your localhost, populates with HTML, and then inserts script into the textboxes to try and execute XSS. 

# Prior to Starting
Before starting, you will need need to enable WWW on Windows, which is covered in my [testing set-up tutorial last week](https://medium.com/@nlarkinwork/test-lab-set-up-b451a5ec8c1b):

    1. From the Start menu, search features and select “Turn Windows Features on or off” 
    2. Select Internet Information Services
    3. Select Web Management Tools
    a. Under IIS 6 Management Compatibility, check “IIS Metabase and IIS 6 configuration compatibility”
    4. Go back to Internet Information Services
    5. Select World Wide Web Services
    a. Under Application Development Features select CGI
    6. Click “Ok”

After completing these steps, get my repository using the command below. (If you have not used Git before, [here is a tutorial to get started](https://git-scm.com/book/en/v2/Getting-Started-Git-Basics).

Open Powershell in the folder where the files were saved and enter `.\scriptTest.ps1`
You will see Internet Explorer popped up with a form that was submitted.

# Run-through

The first part of our script creates the website in the folder for localhost and populates it with HTML
  `New-Item C:\inetpub\wwwroot\index.html -type file
  echo '<html>

    <form action="#">
      <h1>Hello Hackers!!! Enter your name!</h1>

      First name: <input id="t1" type="text" name="fname">
      <br>
      Last name: <input id="t2" type="text" name="lname">
      <br>
      <input id="upload" type="submit" value="Submit">
    </form>

  </html>'  > C:\inetpub\wwwroot\index.html`
  
It then Opens up Internet Explorer to go to localhost
  `$ie = New-Object -Com "InternetExplorer.Application"
  $ie.Navigate("localhost")
  $ie.Visible = $true`
  
Finally, it populates the textboxes with script and submits the form
  `$doc = $ie.document
  $doc.getElementById("t1").value = "<script>alert(1);</script>"
  $doc.getElementById("t2").value = "<script>alert(1);</script>"
  $ie.Document.getElementById("upload").Click() 
  echo "Finished"`

[Here is a GIF of the final run through](https://imgur.com/a/zHlkv)

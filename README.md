### Report Phishing

The script was made to continuously check if the fake pages are online and report it to the hosting providers until the takedown is done

### USAGE
Configure the report_phishing.sh file with the credentials of the email that will be used to send notifications

    email_sending="xxxxxx@gmail.com"
    time="10800"   #3 hours in seconds
    user_pwd="xxxxxx@gmail.com:XXXXXXXXXXX"
    security_team_name="RedTeam"
    original_website="https://original_site.com.br"

Insert the suspicious domains in the **domains** file, line by line

running  ` ./reports_phishing.sh`
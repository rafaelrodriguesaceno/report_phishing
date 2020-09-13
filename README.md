### Report Phishing

The script was made to continuously check if the fake pages are online and report it to the hosting providers until the takedown is done


- Test if the site is online
- Detects the hosting provider 
- Send email to hosting provider's @abuse requesting takedown
- Runs again every 3 hours by default


### Usage
Configure the report_phishing.sh file with the credentials of the email that will be used to send notifications

    email_sending="xxxxxx@gmail.com"
    time="10800"   #3 hours in seconds
    user_pwd="xxxxxx@gmail.com:XXXXXXXXXXX"
    security_team_name="RedTeam"
    original_website="https://original_site.com.br"
    bucket_name="report_s3_bucket"

Configure a aws role to have permission to send and synchronize files with aws s3

Insert the suspicious domains in the **domains** file, line by line
aws s3 cp domains s3://bucket_name/ 
the instance will automatically synchronize this list with the bucket

Insert the new abuse domains in the **hosted.csv** file, line by line
aws s3 cp hosted.csv s3://bucket_name/ 
the instance will automatically synchronize this list with the bucket

Take offline phishing list 
aws s3 cp s3://bucket_name/phishing_offline.csv . 


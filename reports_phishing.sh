#!/bin/bash
bucket_name="report_s3_bucket"
email_sending="XXXXXXXXX@gmail.com"
time="21600"   #6 hours
user_pwd="XXXXXXXXX@gmail.com:XXXXXXXXXX"
security_team_name="red team"
original_website="www.company.com"

while [ : ]
do
aws s3 sync s3://$bucket_name .
aws s3 cp phishing_offline.csv s3://bucket_name
rm -r phishing_online.csv
rm -r phishing_infomation.csv
#check if you are online
   cat domains.csv|while read is_online
    do
    read -d, phishing < <(echo ${is_online})
    if curl -I -s -L "$phishing" | grep "200"; then
    echo $phishing >>phishing_online.csv
    else
    echo $phishing >>phishing_offline.csv
    fi
    done
       # Get website information
        cat phishing_online.csv|while read domain
        do
        ipaddress=`dig $domain +short`
        nameserver=`dig ns $domain +short`
        ipaddress_space=`echo -e "$ipaddress" | tr '\n' ',' | tr -d "[:blank:]"`
        nameserver_space=`echo -e "$nameserver" | tr '\n' ',' | tr -d "[:blank:]"`
        echo -e "$domain,$ipaddress_space$nameserver_space" >> phishing_infomation.csv
        done
#  find hosting and send email

  cat hosted.csv|while read hostedname email
  do
    read -d, hosted col3 < <(echo ${hostedname})
    echo "searching :$hosted"

            cat phishing_infomation.csv | grep $hosted|while read find_hosted
            do
                read -d, phishing col2 < <(echo $find_hosted)
                echo "I found phishing :$phishing hosted at $hosted "
                echo "Sending an email to: $email"
            curl --url 'smtps://smtp.gmail.com:465' --ssl-reqd \
            --mail-from  '${email_sending}' \
            --mail-rcpt  ''$email''   \
            --user       ''$user_pwd''     \
            -T <(echo -e 'From: ${email_sending}\nTo: '${email}'\nSubject: Phishing Detected

            We are the computer security incident response team for
            '$security_team_name'

            You've received this message because you are the Registrar contact for the domain mentioned below. This message is intended for the person responsible for treating abuse cases and if this is not thecorrect address, please forward this message to the appropriate party We have detected the following domain being used for fraud: $phishing This is a domain that pretends to be a domain of our company, whose official website is $original_website and it is associated with fraudulent pages classified as URL PHISHING
            )
            done

done
    sleep $time
done

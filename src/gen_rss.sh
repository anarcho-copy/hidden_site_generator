#!/bin/bash
#this section is for anarcho-copy.org server only.
#https://twitrss.me website source codes: https://github.com/ciderpunx/twitrssme
#for an alternative system recommendation: anarchocopy@protonmail.com

runuser -l tor-web -c 'docker exec -it hiddensite torsocks  wget -O /tmp/rss.xml  https://twitrss.me/twitter_user_to_rss/?user=anarcho_copy' #if directory is exist will be skip"
runuser -l tor-web -c 'docker cp hiddensite:/tmp/rss.xml /var/www/public/anarcho-copy.org/'


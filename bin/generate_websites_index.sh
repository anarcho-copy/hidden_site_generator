#!/bin/bash
cd "$(dirname "$0")";

. config.sh #import
. $template/websites_html.sh  #import
mkdir -p $workdir/siteler

sqlite3 $data_base "SELECT title,url FROM websites" > $temp/websites.txt #create txt db


function websites_index() { #loop
while IFS="|" read -r title url;
do
cat <<EOT
  <tr>
    <td>$title</td>
    <td><a href="$url">$url</a></td>
  </tr>
EOT
done < $temp/websites.txt
}

websites_html > $workdir/siteler/index.html

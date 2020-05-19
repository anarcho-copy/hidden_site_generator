#!/bin/bash
#called from ../../bin/generate_author_pages.sh

function generate_list() {
cat <<EOT
  <li><a href="/copy/$url">$title</a></li>
EOT
}

function generate_author_pages_html() {
IFS="|" read first_url first_title < $temp/.author_index.txt
cat <<EOT
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>$author kitapları pdf</title>
</head>
<body>
<h1><a href="../">../</a> $author kitapları pdf</h1>
<img src="/copy/$first_url/image.jpeg" alt="$first_title" height="100"/>
<hr>
<p><a href="/pdf/${url_array[$(($i - 1))]}">prev</a> | <a href="/pdf/${url_array[$(($i + 1))]}">next</a></p>
<br>
<ul>
$(ifs_loop_ai generate_list)
</ul>
</body>
</html>
EOT
i=$(($i + 1));
}

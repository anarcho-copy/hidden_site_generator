#!/bin/bash
#called from ../../bin/generate_author_pages.sh

function generate_list() {
cat <<EOT
  <li><a href="/copy/$url/">$title</a></li>
EOT
}

function generate_author_pages_html() {
IFS="|" read first_url first_title < $temp/.author_index.txt
cat <<EOT
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!--force_base_href-->
<title>$author kitapları pdf</title>
$style
</head>
<body class="bg-gray">
<div id="holy" class="container-lg bg-white h-100">
    <div id="header" class="px-1 bg-white">
        <nav class="UnderlineNav UnderlineNav--right px-2">
        <a class="UnderlineNav-actions muted-link h2" href="/index.html">
    $site_title</a>
       </nav>
   </div>
<br>
<div role="main" id="main" class="holy-main markdown-body px-4 bg-white">
<h1><a href="/pdf/">../</a> $author kitapları pdf</h1>
<img src="/copy/$first_url/image.jpeg" alt="$first_title" height="100"/>
<hr>
<p><a href="/pdf/${url_array[$(($i - 1))]}/">prev</a> | <a href="/pdf/${url_array[$(($i + 1))]}/">next</a></p>
<br>
<ul>
$(ifs_loop_ai generate_list)
</ul>
</div>
</div>
</body>
</html>
EOT
i=$(($i + 1));
}

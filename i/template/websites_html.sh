#!/bin/bash
#called from ../../bin/generate_websites_index.sh

function websites_html() {

cat <<EOT
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!--force_base_href-->
<title>Siteler</title>
$style
<style>
table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

td, th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: #dddddd;
}
</style>
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
<h1>Referans Siteler</h1>
<hr>
<table>
  <tr>
    <th>Başlık</th>
    <th>URL</th>
  </tr>
$(websites_index)
  <tr>
    <td>$site_title (onion service)</td>
    <td><a href="$hidden_site">$([ -z "$hidden_site" ] && echo "Not running" || echo "$hidden_site")</a></td>
  </tr>
</table>
</br></br>
</div>
</div>
</body>
</html>
EOT

}

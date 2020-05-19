#!/bin/bash
#called from ../../bin/generate_websites_index.sh

function websites_html() {

cat <<EOT
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<title>Siteler</title>
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
<body>
<h1>Siteler:</h1>
<hr>
<table>
  <tr>
    <th>Başlık</th>
    <th>URL</th>
  </tr>
$(websites_index)
</table>
</body>
</html>
EOT

}

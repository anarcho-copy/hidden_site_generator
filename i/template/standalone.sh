#!/bin/bash
#called from  ../../run_server.sh

function print_standalone() {
cat << EOF
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>anarcho-copy.org pdf indeksi</title>
<style>
.author-name a:hover{
  color: red;
}
.author-name a {
  text-decoration: none;
  color: black;
}
.book-name a:visited {
  color: green;
}
.letters a:hover {
  color: red;
}
.letters a {
  text-decoration: none;
}
.letters a:visited {
  color: green;
}
</style>
</head>
<body>
$(src/standalone_html.sh)
</body>
</html>
EOF
}

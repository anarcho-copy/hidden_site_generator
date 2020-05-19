#!/bin/bash
#called from ../../bin/books_index_without_zines.sh

function books_index_without_zines_html() {
cat <<EOT
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>normal kitaplar</title>
</head>
<body>
<h1>normal kitaplar:</h1>
<hr>
<br>
<ul>
$(books_index_without_zines)
</ul>
</body>
</html>
EOT
}

#!/bin/bash
#called from ../../bin/author_index.sh

function author_index_html() {
cat <<EOT
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>yazar kitapları</title>
</head>
<body>
<h1>yazar kitapları pdf</h1>
<hr>
<br>
<ul>
$(author_index)
</ul>
</body>
</html>
EOT

}


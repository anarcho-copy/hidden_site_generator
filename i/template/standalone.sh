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
</head>
<body>
$(src/standalone_html.sh)
</body>
</html>
EOF
}

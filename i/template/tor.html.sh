#!/bin/bash
#called from  ../../run_server.sh

function tor.html() {
torUrl="$(./run_server.sh -t)"
cat << EOF
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>anarcho-copy.org tor adress</title>
</head>
<body>
<a href="http://$torUrl">$torUrl</a>
<hr />
<pre>powered by <a href="https://github.com/opsxcq/docker-tor-hiddenservice-nginx">docker-tor-hiddenservice-nginx</a></pre>
</body>
</html>
EOF

}

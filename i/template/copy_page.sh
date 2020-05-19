#!/bin/bash
#called from ../../bin/generate_copy_files.sh

function copy_page() {

cat <<EOT
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="language" content="$lang">
<meta http-equiv="content-type" content="text/html">
<meta name="author" content="anarcho-copy.org Collective" />
<meta name="publisher" content="anarcho-copy.org Collective">
<title>$author - $title PDF</title>
<meta name="description" content="$author - $title PDF dosyası indirme sayfası. $description" />
<meta name="keywords" content="pdf, $title pdf, $title, $author, indir$( [[ -n "$keywords" ]] && echo ", $keywords" )" />
<meta name="copyright" content="Copy(A), No Copyright, Anti-Copyright" />
<meta name="robots" content="index,follow" />
<meta name="generator" content="$generator" />
<meta http-equiv="Content-Style-Type" content="text/css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="/css/primer.css" rel="stylesheet" /> <!--source: https://unpkg.com/@primer/css/dist/primer.css / https://primer.style/css/getting-started-->
<style>
.article {
background-color:gray;
}
</style>
</head>
<body>
<h1><a href="$cgi_search${ae_array[$i]}">$author</a> / $title PFD</h1>$( [[ -n "$subtitle" ]] && echo -ne "\n<h2>$subtitle</h2>")
<hr>
<p><a href="/copy/${books_array[$(($j - 1))]}">prev</a> | <a href="/copy/${books_array[$(($j + 1))]}">next</a></p> <!-- next and prev -->
<hr>
<img src="image.jpeg" alt="$title - $author"/>
<br>
<a href="/free/$url.pdf">$url.pdf</a>
<p>boyut : $(ls -lh $pdf_dir/$url.pdf | cut -f 5 -d ' ' ) $( [[ -n "$type" ]] && echo -ne '| <a href="/link/pdf-a.html" style="color:red;text-decoration: none"> PDF/A</a><span style="color:green"> &check;</span>')</p>
$(echo -ne "${article[$id]}")
<hr>
<pre>sayfa oluşturulma tarihi \$Date: $(date '+%d/%m/%Y %H:%M:%S') \$ $([ ! -z "${date_array[$i]}" ] && echo "| pdf yükleme tarihi ${date_array[$i]}")</pre>
</body>
</html>
EOT
i=$(($i + 1))
j=$(($j + 1))
t=$(($t + 1))
}


#$cgi_search$(echo $author | name_encode)
#echo "\$Date: $(date '+%d/%m/%Y %H:%M:%S') \$"


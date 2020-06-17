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
<!--force_base_href-->
<title>$author - $title PDF</title>
<meta name="description" content="$author - $title PDF dosyası indirme sayfası. $description" />
<meta name="keywords" content="pdf, $title pdf, $title, $author, indir$( [[ -n "$keywords" ]] && echo ", $keywords" )" />
<meta name="copyright" content="No Copyright" />
<meta name="robots" content="index,follow" />
<meta name="generator" content="$generator" />
<meta http-equiv="Content-Style-Type" content="text/css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
$style
<style>
.article {
background-color:gray;
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
<!-- /$cgi_search${ae_array[$i]} -->
<h1><a href="/index/#$(echo "$author" | bash $url_slug )">$author</a> / $title PFD</h1>$( [[ -n "$subtitle" ]] && echo -ne "\n<h2>$subtitle</h2>")
<p><a href="/copy/${books_array[$(($j - 1))]}/">prev</a> | <a href="/copy/${books_array[$(($j + 1))]}/">next</a></p> <!-- next and prev -->
<hr>
<img src="/copy/$url/image.jpeg" alt="$title - $author"/>
<br>
<br>
<a class="btn btn-primary mr-2" type="button" href="/free/$url.pdf">$url.pdf</a>
<br>
<br>
<div class="flash flash-warn">
<p>boyut : $(ls -lh $pdf_dir/$url.pdf | cut -f 5 -d ' ' ) $( [[ -n "$type" ]] && echo -ne '| <a href="/link/pdf-a.html" style="color:red;text-decoration: none"> PDF/A</a><span style="color:green"> &check;</span>')
| <a href="/copy/$url/md5.html">MD5 INFO</a> | <a href="/copy/$url/info.html">EXIF INFO</a>
</p></div>
<br>
<blockquote>
$(echo -ne "${article[$id]}")
</blockquote>
<hr>
<pre>sayfa oluşturulma tarihi \$Date: $(date '+%d/%m/%Y %H:%M:%S') \$ $([ ! -z "${date_array[$i]}" ] && echo "| pdf yükleme tarihi ${date_array[$i]}")</pre>
</div>
</div>
</body>
</html>
EOT
i=$(($i + 1))
j=$(($j + 1))
t=$(($t + 1))
}


#$cgi_search$(echo $author | name_encode)
#echo "\$Date: $(date '+%d/%m/%Y %H:%M:%S') \$"


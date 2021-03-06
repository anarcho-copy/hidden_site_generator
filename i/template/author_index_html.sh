#!/bin/bash
#called from ../../bin/author_index.sh

function author_index_html() {
cat <<EOT
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="language" content="$lang">
<meta http-equiv="content-type" content="text/html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="$site_title Service. Books PDF" />
<meta name="copyright" content="No Copyright" />
<meta name="robots" content="$robots_config" />
<meta name="generator" content="$generator" />
<meta http-equiv="Content-Style-Type" content="text/css">

<!--force_base_href-->
<title>Dergi, Gazete, Fanzin ve Spesifik Yazarlar</title>

$style
<style>
* {
  box-sizing: border-box;
}

#myInput {
  background-image: url('/css/searchicon.png');
  background-position: 10px 12px;
  background-repeat: no-repeat;
  width: 100%;
  font-size: 16px;
  padding: 12px 20px 12px 40px;
  border: 1px solid #ddd;
  margin-bottom: 12px;
}

#myUL {
  list-style-type: none;
  padding: 0;
  margin: 0;
}

#myUL li a {
  border: 1px solid #ddd;
  margin-top: -1px; /* Prevent double borders */
  background-color: #f6f6f6;
  padding: 12px;
  text-decoration: none;
  font-size: 18px;
  color: black;
  display: block
}

#myUL li a:hover:not(.header) {
  background-color: #eee;
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
<h1>Dergi, Gazete, Fanzin ve Spesifik Yazarlar&nbsp;<span class="Counter Counter--gray">$zine_count</span></h1>
<h2><a href="/index/">Daha fazlası için tıkla</a></h2>
<input type="text" id="myInput" onkeyup="myFunction()" placeholder="Ara.." title="Bir isim yaz">
<noscript>Lütfen arama filtresi için JavaScript'inizi etkinleştirin!</noscript>

<ul id="myUL">
$(author_index)
</ul>

<script>
function myFunction() {
    var input, filter, ul, li, a, i, txtValue;
    input = document.getElementById("myInput");
    filter = input.value.toUpperCase();
    ul = document.getElementById("myUL");
    li = ul.getElementsByTagName("li");
    for (i = 0; i < li.length; i++) {
        a = li[i].getElementsByTagName("a")[0];
        txtValue = a.textContent || a.innerText;
        if (txtValue.toUpperCase().indexOf(filter) > -1) {
            li[i].style.display = "";
        } else {
            li[i].style.display = "none";
        }
    }
}
</script>

<br/><br/>

</div>
</div>
</body>
</html>
EOT

}


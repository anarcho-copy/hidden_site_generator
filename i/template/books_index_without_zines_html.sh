#!/bin/bash
#called from ../../bin/books_index_without_zines.sh

function check_tor() {
if [ -z "$hidden_site" ]
then
cat <<EOF
<div class="flash flash-error">
onion servisi çalışmıyor
</div>
EOF
else
cat <<EOF
<div class="flash flash-success">
onion servisi şu adreste çalışıyor:&nbsp;
<a href="$hidden_site">$hidden_site</a>
</div>
EOF
fi
}


function books_index_without_zines_html() {
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
<title>$site_title Service. Books PDF</title>

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
<div class="flash flash-success f4">
  <!-- <%= octicon "shield-check" %> -->
  <svg class="octicon octicon-shield-check v-align-bottom" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">  <path fill-rule="evenodd" clip-rule="evenodd" d="M11.9275 3.55567C11.9748 3.54134 12.0252 3.54134 12.0725 3.55567L19.3225 5.75264C19.4292 5.78497 19.5 5.88157 19.5 5.99039V11C19.5 13.4031 18.7773 15.3203 17.5164 16.847C16.246 18.3853 14.3925 19.5706 12.0703 20.4278C12.0253 20.4444 11.9746 20.4444 11.9297 20.4278C9.60747 19.5706 7.75398 18.3853 6.48358 16.847C5.2227 15.3203 4.5 13.4031 4.5 11L4.5 5.9904C4.5 5.88158 4.57082 5.78496 4.6775 5.75264L11.9275 3.55567ZM12.5075 2.12013C12.1766 2.01985 11.8234 2.01985 11.4925 2.12013L4.24249 4.3171C3.50587 4.54032 3 5.21807 3 5.9904L3 11C3 13.7306 3.83104 15.9908 5.32701 17.8022C6.81347 19.6021 8.91996 20.9157 11.4102 21.835C11.7904 21.9753 12.2095 21.9753 12.5897 21.835C15.08 20.9157 17.1865 19.6021 18.673 17.8022C20.169 15.9908 21 13.7306 21 11V5.99039C21 5.21804 20.4941 4.54031 19.7575 4.3171L12.5075 2.12013ZM16.2803 9.78033C16.5732 9.48744 16.5732 9.01256 16.2803 8.71967C15.9874 8.42678 15.5126 8.42678 15.2197 8.71967L11 12.9393L9.28033 11.2197C8.98744 10.9268 8.51256 10.9268 8.21967 11.2197C7.92678 11.5126 7.92678 11.9874 8.21967 12.2803L10.4697 14.5303C10.7626 14.8232 11.2374 14.8232 11.5303 14.5303L16.2803 9.78033Z"></path></svg>
  <a href="https://git.anarcho-copy.org/www.anarcho-copy.org/hidden_site_generator">Anarcho-Copy HTML generatörü</a> $(git describe --tags)
</div>
<ul>
<li><h2><a href="/pdf/">Dergi, Gazete, Fanzin ve Spesifik Yazarlar</a>&nbsp;<span class="Counter Counter--gray">$zine_count</span></h2></li>
<li><h2><a href="/index/">Kapsamlı İndex</a>&nbsp;<span class="Counter Counter--gray">$total_count</span></h2></li>
 - <a href="/print.html">Bağımsız HTML (basıma uygun)</a><br/>
 - <a href="https://git.anarcho-copy.org/www.anarcho-copy.org/hidden_site_generator/raw/master/var/books.db">Kitaplar için sqlite veritabanı</a><br/>
 - <a href="#duck">DuckDuckGo araması yap</a>
<li><h2><a href="/siteler/">Referans Siteler </a></h2></li>
</ul>

$(check_tor)

<hr>

<h1 id="kitaplar">Kitaplar&nbsp;<span class="Counter Counter--gray">$books_count</span></h1>

<div id="search">
<input type="text" id="myInput" onkeyup="myFunction()" placeholder="Kitapları filtrele.." title="Bir isim yaz">
<noscript>Lütfen arama filtresi için JavaScript'inizi etkinleştirin!</noscript>
</div>

<ul id="myUL">
$(books_index_without_zines)
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
</br>
<div id="duck">
<br/>
<iframe src="https://duckduckgo.com/search.html?width=180&duck=yes&site=anarcho-copy.org&prefill=Search at DuckDuckGo" style="overflow:hidden;margin:0;padding:0;width:313px;height:60px;" frameborder="0"></iframe> <p><a href="https://duckduckgo.com/privacy">DuckDuckGo Privacy</a></p>
</br>
</div>
<br/>
<p>$(date -u)</p>
</div>
</div>
</body>
</html>
EOT
}

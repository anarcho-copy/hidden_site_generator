#!/bin/bash
cd "$(dirname "$0")"

. config.sh #import

function guide() {
echo "usage: ./`basename $0` [-c] [-i|-e|-m]"
echo "-c       delete dir"
echo "-i       image generator"
echo "-e       exif page generator"
echo "-m       md5 page generator"
}

function check_dir() {
mkdir -p $listenCopy/$url/
}

#LOOP for FUNCTIONS
function generate() {
ifs_loop_abt check_dir $1; # $1 : image_create, md5_create, exif_create.
}


#IMAGE CREATOR

function generate_image() {

function image_create() {
echo quit | gs -sDEVICE=jpeg -sOutputFile=$listenCopy/$url/image.jpeg \
-dLastPage=1 $pdf_dir/$url.pdf > /dev/null 2>&1 && echo "$url.pdf image created" || echo "image don't created"
convert $listenCopy/$url/image.jpeg -resize 400x566 $listenCopy/$url/image.jpeg && echo "image resized"
convert $listenCopy/$url/image.jpeg -quality 20 $listenCopy/$url/image.jpeg &&  echo "reduced image quality"
echo "--------------"
}
generate image_create && echo "image process ended"
}


#EXIF CREATOR

function generate_exif() {

function exif_create() {
exiftool $pdf_dir/$url.pdf > $listenCopy/$url/info.txt && \
cat > $listenCopy/$url/info.html << EOF && echo "$listenCopy/$url/info.html table created"
<!DOCTYPE html>
<html>
<head>
<title>exif bilgisi</title>
<meta charset="utf-8">
<!--force_base_href-->
<meta name="robots" content="noindex,nofollow" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
$style
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
 <a href="/copy/$url/">geri</a>
 <hr>
  <h1>exif bilgisi</h1>
  $($convert_table -f $listenCopy/$url/info.txt)
 <br>
 <hr>
  <p>$(date -u) <a href="/tools/convert.sh.html">convert.sh</a></p>
</div>
</div>
</body>
</html>
EOF
}
generate exif_create && echo "exif process ended";
}



#MD5 CREATOR

function generate_md5() {

function md5_create() {
cat > $listenCopy/$url/md5.html << EOF && echo "$listenCopy/$url/md5.html generated"
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="robots" content="noindex,nofollow" />
<!--force_base_href-->
<title>md5 of $url.pdf</title>
$style
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
 <a href="/copy/$url/">geri</a>
 <br/>
 <h1>$(md5sum $pdf_dir/$url.pdf | awk '{ print $1 }' || echo "can not showing md5")</h1>
</div>
</div>
</body>
</html>
EOF
}
generate md5_create && echo "md5 process ended"
}




while getopts ":ciem" opt; do
  case ${opt} in
    c ) rmListenCopy;
      ;;
    i ) generate_image;
      ;;
    e ) generate_exif;
      ;;
    m ) generate_md5;
      ;;
    \? ) guide;
      ;;
  esac
done

if [ "$#" -lt 1 ]; then
    guide;
fi

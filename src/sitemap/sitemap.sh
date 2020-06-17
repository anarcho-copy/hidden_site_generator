#!/bin/bash
#
# https://github.com/mcmilk/sitemap-generator

# url configuration
URL="" #not yet

# values: always hourly daily weekly monthly yearly never
FREQ="monthly"

# begin new sitemap
exec 1> sitemap.xml

# print head
echo '<?xml version="1.0" encoding="UTF-8"?>'
echo '<!-- generator="Milkys Sitemap Generator, https://github.com/mcmilk/sitemap-generator" -->'
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'

# print urls
IFS=$'\r\n' GLOBIGNORE='*' command eval "OPTIONS=($(cat $0.options))"
find . -type f "${OPTIONS[@]}" -printf "%TY-%Tm-%Td%p\n" | \
while read -r line; do
  DATE=${line:0:10}
  FILE=${line:12}
  echo "<url>"
  echo " <loc>${URL}${FILE}</loc>"
  echo " <lastmod>$DATE</lastmod>"
  echo " <changefreq>$FREQ</changefreq>"


  grep ".pdf" <<< "${FILE}" > /dev/null 2>&1 &&  echo " <priority>0.8</priority>"
  grep "/copy/" <<< "${URL}${FILE}" > /dev/null 2>&1  && echo " <priority>1.0</priority>"
  grep "/link/" <<< "${URL}${FILE}" > /dev/null 2>&1  && echo " <priority>0.3</priority>"
echo "</url>"
done

# print foot
echo "</urlset>"

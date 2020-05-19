#!/bin/bash
cd "$(dirname "$0")"

cp sitemap.sh* /var/www/public/anarcho-copy.org/

echo -e "Starting XML sitemap process \n creating map wait.."
cd /var/www/public/anarcho-copy.org/

./sitemap.sh && echo "map created" || echo "map don't created";





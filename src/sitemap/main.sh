#!/bin/bash
cd "$(dirname "$0")"
site_out=""; #not yet

cp sitemap.sh* $site_out

echo -e "Starting XML sitemap process \n creating map wait.."
cd $site_out

./sitemap.sh && echo "map created" || echo "map don't created";





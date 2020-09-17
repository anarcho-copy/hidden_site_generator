#!/bin/bash
#diff script for -free- directory
cd "$(dirname "$0")"
cd ../bin/;
. config.sh; #get pdf_dir and temp dir
cd - &> /dev/null

#create pdf list from database
sqlite3 $data_base "SELECT url FROM books;" > $temp/.pdf-ls.txt
rm $temp/pdf-ls.txt &> /dev/null
for i in `<$temp/.pdf-ls.txt`; do echo "$i.pdf" >> $temp/pdf-ls.txt; done

#create pdf list from free/ directory
ls -1 $pdf_dir > $temp/free.ls

#compare
echo -e "\033[0;31mfiles in the free/ directory that are not in the database:\033[0m"
grep -Fxvf $temp/pdf-ls.txt $temp/free.ls || echo -e "\033[1;32mnot found.\033[0m"
echo -e "\033[0;31mfiles in the database that are not in the free/ directory:\033[0m"
grep -Fxvf $temp/free.ls $temp/pdf-ls.txt || echo -e "\033[1;32mnot found.\033[0m"

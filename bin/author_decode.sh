#!/bin/bash
#subclass of generate_copy_files.sh

. config.sh #import


sqlite3 $data_base "SELECT author FROM books;" > $temp/author.txt && echo "table created"

rm $temp/author_encoded.txt &> /dev/null && echo "checking files"
i=1;

echo "encode starting.."

while IFS= read -r author
do
name_encode "$author" >> $temp/author_encoded.txt
echo -ne "\n" >> $temp/author_encoded.txt
echo -ne "$i\r";
i=$(($i + 1))
done < $temp/author.txt

echo "encode ended, saving to $temp/author_encoded.txt"

#readarray -t author_array < $temp/author_encoded.txt && echo "array created"
#create_ae_array


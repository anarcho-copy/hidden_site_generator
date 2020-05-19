#!/bin/bash
#subclass of generate_copy_files.sh


. config.sh #import
. $template/books_index_without_zines_html.sh


function books_index_without_zines() {

#HTML CODE
function generate_html() {
cat <<EOT
  <li><a href="/copy/$url">$title - $author</a></li>
EOT
}

create_books_table;

ifs_loop_bt generate_html;

}

books_index_without_zines_html > $workdir/index.html

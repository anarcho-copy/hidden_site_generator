#!/bin/bash
#subclass of generate_author_pages.sh

. config.sh #import
. $template/author_index_html.sh


function author_index() { #from author_index_html.sh

#HTML CODE
function generate_html() {
cat <<EOT
<li><a href="$url">$author</a></li>
EOT
}

#creating url table
create_author_table; #config.sh

#LOOP FOR GEN HTML
ifs_loop_az generate_html; #ifs_loop_az from config.sh

}



#generating html codes to file
author_index_html > $workdirPdf/index.html


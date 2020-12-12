#!/bin/bash

function guide() {
echo "usage: ./`basename $0` [debian | rhel]"
echo "use debian option to apt based distros, such as Ubuntu."
echo -e "use rhel option to dnf based distros, such as Fedora.\n"
echo "this generator tested under debian and fedora."
exit 0;
}

debian(){
apt-get update && \
    apt-get install \
    ghostscript imagemagick libimage-exiftool-perl sqlite3 coreutils nginx pdfinfo
	# libio-compress-perl libdigest-sha-perl
}


rhel(){
dnf install \
    ghostscript ImageMagick perl-Image-ExifTool sqlite coreutils nginx poppler-utils podman-docker perl-IO-Compress perl-Digest-SHA
}

if [ "$#" -lt 1 ]; then
    guide;
fi

$1

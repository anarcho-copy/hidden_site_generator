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
    apt-get -y install \
    ghostscript imagemagick libimage-exiftool-perl sqlite3 coreutils nginx pdfinfo
}


rhel(){
dnf install -y \
    ghostscript ImageMagick perl-Image-ExifTool sqlite coreutils nginx poppler-utils podman-docker
}

if [ "$#" -lt 1 ]; then
    guide;
fi

$1

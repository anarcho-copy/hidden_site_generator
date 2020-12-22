#!/bin/bash
# these scripts written in GNU bash; version 5.0.16(1)-release (x86_64-pc-linux-gnu)
#  and version 5.0.17(1)-release (x86_64-redhat-linux-gnu)
#  and version 4.4.19(1)-release (x86_64-redhat-linux-gnu)
#  and version 5.1.0(1)-release (aarch64-linux-android)

function guide() {
echo "usage: ./`basename $0` [debian | rhel | termux]"
echo "use debian option to apt based distros, such as Ubuntu."
echo -e "use rhel option to dnf based distros, such as Fedora."
echo -e "use termux option to android termux.\n"
echo "this generator tested under debian and fedora."
exit 0;
}

debian(){
apt-get update && \
    apt-get install \
    ghostscript imagemagick libimage-exiftool-perl sqlite3 coreutils nginx pdfinfo bc
	# libio-compress-perl libdigest-sha-perl
}

rhel() {
dnf install \
    ghostscript ImageMagick perl-Image-ExifTool sqlite coreutils nginx poppler-utils podman-docker perl-IO-Compress perl-Digest-SHA bc
}

termux() {
pkg update && \
    pkg install \
    wget git tor ghostscript imagemagick exiftool sqlite coreutils nginx poppler bc
}


if [ "$#" -lt 1 ]; then
    guide;
fi

$1

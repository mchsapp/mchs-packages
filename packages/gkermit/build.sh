MCHS_PKG_HOMEPAGE=http://www.columbia.edu/kermit/gkermit.html
MCHS_PKG_DESCRIPTION="Simple, Portable, Free File Transfer Software for UNIX"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.00
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=http://ftp.nluug.nl/pub/networking/kermit/archives/gku${MCHS_PKG_VERSION/./}.tar.gz
MCHS_PKG_SHA256=3dbe63291277c4795255343b48b860777fb0a160163d7e1d30b1ee68585593eb
MCHS_PKG_DEPENDS="libandroid-support"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_MAKE_PROCESSES=1

mchs_step_post_get_source() {
	local file filename
	filename=$(basename "$MCHS_PKG_SRCURL")
	file="$MCHS_PKG_CACHEDIR/$filename"
	tar xf "$file" -C "$MCHS_PKG_SRCDIR"
}

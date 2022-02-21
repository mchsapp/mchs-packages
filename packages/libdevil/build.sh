MCHS_PKG_HOMEPAGE=http://openil.sourceforge.net/
MCHS_PKG_DESCRIPTION="A cross-platform image library utilizing a simple syntax"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.8.0
MCHS_PKG_SRCURL=https://github.com/DentonW/DevIL/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=52129f247b26fcb5554643c9e6bbee75c4b9717735fdbf3c6ebff08cee38ad37
MCHS_PKG_DEPENDS="libc++, libjasper, libjpeg-turbo, libpng, libtiff, zlib"

mchs_step_pre_configure() {
	MCHS_PKG_SRCDIR+="/DevIL"
}

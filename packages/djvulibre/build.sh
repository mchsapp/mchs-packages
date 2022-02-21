MCHS_PKG_HOMEPAGE=http://djvu.sourceforge.net/
MCHS_PKG_DESCRIPTION="Suite to create, manipulate and view DjVu ('déjà vu') documents"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.5.28
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=http://downloads.sourceforge.net/djvu/djvulibre-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=fcd009ea7654fde5a83600eb80757bd3a76998e47d13c66b54c8db849f8f2edc
MCHS_PKG_DEPENDS="libtiff"

mchs_step_pre_configure() {
	NOCONFIGURE=1 ./autogen.sh
}

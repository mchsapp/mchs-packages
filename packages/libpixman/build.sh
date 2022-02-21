MCHS_PKG_HOMEPAGE=http://www.pixman.org/
MCHS_PKG_DESCRIPTION="Low-level library for pixel manipulation"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.40.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://cairographics.org/releases/pixman-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=6d200dec3740d9ec4ec8d1180e25779c00bc749f94278c8b9021f5534db223fc
MCHS_PKG_BREAKS="libpixman-dev"
MCHS_PKG_REPLACES="libpixman-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-libpng"

mchs_step_pre_configure() {
	if [ $MCHS_ARCH = arm ]; then
		CFLAGS+=" -fno-integrated-as"
	fi
}

MCHS_PKG_HOMEPAGE=https://gpac.wp.imt.fr/
MCHS_PKG_DESCRIPTION="An open-source multimedia framework focused on modularity and standards compliance"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.0.1
MCHS_PKG_SRCURL=https://github.com/gpac/gpac/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=3b0ffba73c68ea8847027c23f45cd81d705110ec47cf3c36f60e669de867e0af
MCHS_PKG_DEPENDS="zlib"
MCHS_PKG_EXTRA_MAKE_ARGS="STRIP=:"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-x11"

mchs_step_pre_configure() {
	CFLAGS+=" -fPIC"
	for f in $CFLAGS $CPPFLAGS; do
		MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" --extra-cflags=$f"
	done
	for f in $LDFLAGS; do
		MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" --extra-ldflags=$f"
	done
}

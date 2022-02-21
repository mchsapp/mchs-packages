MCHS_PKG_HOMEPAGE=https://tintin.mudhalla.net
MCHS_PKG_DESCRIPTION="Classic text-based MUD client"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.02.12
MCHS_PKG_SRCURL=https://github.com/scandum/tintin/releases/download/$MCHS_PKG_VERSION/tintin-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=b6f9fd4f2c1e7cdc8cff4172d7a80014961b0394380ced9182209dc34d781a00
MCHS_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_file__dev_ptmx=no"
MCHS_PKG_DEPENDS="pcre, libgnutls, zlib"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_post_get_source() {
	MCHS_PKG_SRCDIR+="/src"
	MCHS_PKG_BUILDDIR="$MCHS_PKG_SRCDIR"
}

mchs_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
}

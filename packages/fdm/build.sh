MCHS_PKG_HOMEPAGE=https://github.com/nicm/fdm
MCHS_PKG_DESCRIPTION="A program designed to fetch mail from POP3 or IMAP servers, or receive local mail from stdin, and deliver it in various ways"
MCHS_PKG_LICENSE="ISC, BSD 3-Clause"
MCHS_PKG_LICENSE_FILE="LICENSE, LICENSE.BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.0
MCHS_PKG_SRCURL=https://github.com/nicm/fdm/releases/download/${MCHS_PKG_VERSION}/fdm-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=06b28cb6b792570bc61d7e29b13d2af46b92fea77e058b2b17e11e8f7ed0cea4
MCHS_PKG_DEPENDS="libandroid-glob, libtdb, openssl, pcre, zlib"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--sysconfdir=$MCHS_PREFIX/etc
--localstatedir=$MCHS_PREFIX/var
--disable-static
--enable-pcre
"

mchs_step_pre_configure() {
	# Source distribution does not have separate license files
	for f in LICENSE LICENSE.BSD; do
		cp $MCHS_PKG_BUILDER_DIR/$f $MCHS_PKG_SRCDIR/
	done

	LDFLAGS+=" -landroid-glob"
}

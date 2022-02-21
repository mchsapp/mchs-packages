MCHS_PKG_HOMEPAGE=http://michael.dipperstein.com/crypt/
MCHS_PKG_DESCRIPTION="A crypt(3) implementation"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.2
MCHS_PKG_REVISION=3
MCHS_PKG_SKIP_SRC_EXTRACT=true
MCHS_PKG_DEPENDS="openssl"
MCHS_PKG_BREAKS="libcrypt-dev"
MCHS_PKG_REPLACES="libcrypt-dev"

mchs_step_make_install() {
	$CC $CFLAGS $CPPFLAGS $LDFLAGS -Wall -Wextra -fPIC -shared $MCHS_PKG_BUILDER_DIR/crypt3.c -lcrypto -o $MCHS_PREFIX/lib/libcrypt.so
	mkdir -p $MCHS_PREFIX/include/
	cp $MCHS_PKG_BUILDER_DIR/crypt.h $MCHS_PREFIX/include/
	cp $MCHS_PKG_BUILDER_DIR/LICENSE $MCHS_PKG_SRCDIR/
}

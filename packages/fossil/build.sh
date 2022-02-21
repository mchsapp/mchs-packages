MCHS_PKG_HOMEPAGE=https://www.fossil-scm.org
MCHS_PKG_DESCRIPTION="DSCM with built-in wiki, http interface and server, tickets database"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_LICENSE_FILE="COPYRIGHT-BSD2.txt"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.17
MCHS_PKG_SRCURL=https://www.fossil-scm.org/home/tarball/version-$MCHS_PKG_VERSION/fossil-src-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=5c7f1c73f7b5e2af24e10e40f0e07391909c1230b9e284a9d548059e7f377dbf
MCHS_PKG_DEPENDS="libsqlite, openssl, zlib"

mchs_step_pre_configure() {
	# Avoid mixup of flags between cross compilation
	# and native build.
	CC="$CC $CPPFLAGS $CFLAGS $LDFLAGS"
	unset CFLAGS LDFLAGS
}

mchs_step_configure() {
	$MCHS_PKG_SRCDIR/configure \
		--prefix=$MCHS_PREFIX \
		--host=$MCHS_HOST_PLATFORM \
		--json \
		--disable-internal-sqlite \
		--with-openssl=$MCHS_PREFIX \
		--with-zlib=$MCHS_PREFIX
}

MCHS_PKG_HOMEPAGE=https://github.com/sqlcipher/sqlcipher
MCHS_PKG_DESCRIPTION="SQLCipher is an SQLite extension that provides 256 bit AES encryption of database files"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.5.0
MCHS_PKG_SRCURL=https://github.com/sqlcipher/sqlcipher/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=20c46a855c47d5a0a159fdcaa8491ec7bdbaa706a734ee52bc76188b929afb14
MCHS_PKG_DEPENDS="openssl"
MCHS_PKG_BUILD_DEPENDS="tcl"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--enable-tempstore=yes
--with-tcl=${MCHS_PREFIX}/lib
TCLLIBDIR=${MCHS_PREFIX}/lib/tcl8.6/sqlite
"

mchs_step_pre_configure() {
	CPPFLAGS+=" -DSQLITE_HAS_CODEC"
}

MCHS_PKG_HOMEPAGE=https://www.fefe.de/gatling/
MCHS_PKG_DESCRIPTION="A high performance http, ftp and smb server"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.15
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://www.fefe.de/gatling/gatling-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=6fa329d0ced0c80deb8dde5460e9d9e984bee94f265043d7fdec0e253dce9aa4
MCHS_PKG_DEPENDS="libcrypt, libiconv, openssl, zlib"
MCHS_PKG_BUILD_DEPENDS="libowfat"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	CPPFLAGS+=" -I$MCHS_PREFIX/include/libowfat"
	LDFLAGS+=" -lcrypt -lcrypto -liconv"
	make -j $MCHS_MAKE_PROCESSES CROSS="${CC/clang}"
}

mchs_step_make_install() {
	make install prefix=$MCHS_PREFIX MANDIR=$MCHS_PREFIX/share/man
}

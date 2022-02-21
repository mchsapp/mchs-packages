MCHS_PKG_HOMEPAGE=https://www.tarsnap.com/spiped.html
MCHS_PKG_DESCRIPTION="a utility for creating symmetrically encrypted and authenticated pipes between socket addresses"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.6.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/Tarsnap/spiped/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=d14a0c802f97bfe4da6c1a6c1ec882b7ffb94d28aee1eea11e6ad532fc21254c
MCHS_PKG_DEPENDS="openssl"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make () {
	CFLAGS+=" $CPPFLAGS"
	env LDADD_EXTRA="$LDFLAGS" \
		make -j "$MCHS_MAKE_PROCESSES" BINDIR="$MCHS_PREFIX/bin" \
			MAN1DIR="$MCHS_PREFIX/share/man/man1"
}

mchs_step_make_install() {
	make install BINDIR="$MCHS_PREFIX/bin" \
		MAN1DIR="$MCHS_PREFIX/share/man/man1"
}

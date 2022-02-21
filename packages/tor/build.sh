MCHS_PKG_HOMEPAGE=https://www.torproject.org
MCHS_PKG_DESCRIPTION="The Onion Router anonymizing overlay network"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.4.6.10
MCHS_PKG_SRCURL=https://www.torproject.org/dist/tor-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=94ccd60e04e558f33be73032bc84ea241660f92f58cfb88789bda6893739e31c
MCHS_PKG_DEPENDS="libevent, openssl, liblzma, zlib, libandroid-glob"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-zstd --disable-unittests"
MCHS_PKG_CONFFILES="etc/tor/torrc"
MCHS_PKG_SERVICE_SCRIPT=("tor" 'exec tor 2>&1')

mchs_step_post_make_install() {
	# use default config
	mv "$MCHS_PREFIX/etc/tor/torrc.sample" "$MCHS_PREFIX/etc/tor/torrc"
}

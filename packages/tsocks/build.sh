MCHS_PKG_HOMEPAGE=http://tsocks.sf.net
MCHS_PKG_DESCRIPTION="transparent network access through a SOCKS 4 or 5 proxy"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
MCHS_PKG_VERSION=1.8beta5
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/project/tsocks/tsocks/1.8%20beta%205/tsocks-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=849d7ef5af80d03e76cc05ed9fb8fa2bcc2b724b51ebfd1b6be11c7863f5b347
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS=" --with-conf=$MCHS_PREFIX/etc/tsocks.conf"

mchs_step_post_get_source() {
	cp $MCHS_PKG_SRCDIR/tsocks-1.8/* $MCHS_PKG_SRCDIR/
}

mchs_step_pre_configure() {
	cp $MCHS_PKG_SRCDIR/tsocks.conf.complex.example $MCHS_PREFIX/etc/tsocks.conf
}

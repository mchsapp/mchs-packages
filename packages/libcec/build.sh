MCHS_PKG_HOMEPAGE=http://libcec.pulse-eight.com/
MCHS_PKG_DESCRIPTION="Provides support for Pulse-Eight's USB-CEC adapter and other CEC capable hardware"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=6.0.2
MCHS_PKG_SRCURL=https://github.com/Pulse-Eight/libcec/archive/libcec-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=090696d7a4fb772d7acebbb06f91ab92e025531c7c91824046b9e4e71ecb3377
MCHS_PKG_DEPENDS="libc++, libp8-platform"

mchs_step_post_make_install() {
	install -Dm600 -t $MCHS_PREFIX/share/man/man1 \
		$MCHS_PKG_SRCDIR/debian/cec-client.1
}

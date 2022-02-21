MCHS_PKG_HOMEPAGE=http://dtach.sourceforge.net/
MCHS_PKG_DESCRIPTION="Emulates the detach feature of screen"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.9
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/sourceforge/dtach/dtach-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=32e9fd6923c553c443fab4ec9c1f95d83fa47b771e6e1dafb018c567291492f3

mchs_step_make_install() {
	install -Dm700 -t ${MCHS_PREFIX}/bin dtach
	install -Dm600 -t ${MCHS_PREFIX}/share/man/man1 ${MCHS_PKG_SRCDIR}/dtach.1
}

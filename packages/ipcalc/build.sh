MCHS_PKG_HOMEPAGE=http://jodies.de/ipcalc
MCHS_PKG_DESCRIPTION="Calculates IP broadcast, network, Cisco wildcard mask, and host ranges"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_DEPENDS="perl"
MCHS_PKG_VERSION=0.41
MCHS_PKG_SRCURL=http://jodies.de/ipcalc-archive/ipcalc-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=dda9c571ce3369e5b6b06e92790434b54bec1f2b03f1c9df054c0988aa4e2e8a

mchs_step_make_install() {
  cp $MCHS_PKG_SRCDIR/ipcalc $MCHS_PREFIX/bin/
}


MCHS_PKG_HOMEPAGE=https://dickey.his.com/cdk/cdk.html
MCHS_PKG_DESCRIPTION="Curses Development Kit"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
_DATE=20211216
MCHS_PKG_VERSION=5.0-${_DATE}
MCHS_PKG_SRCURL=https://github.com/ThomasDickey/cdk-snapshots/archive/refs/tags/t${_DATE}.tar.gz
MCHS_PKG_SHA256=9cb2d1cf59f1adbe043d64ee2aa2f5678b65627ec38524ce0c56374c5d1f3700
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--with-shared
"

MCHS_PKG_HOMEPAGE=https://github.com/cernekee/stoken
MCHS_PKG_DESCRIPTION="Software Token for Linux/UNIX"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.92
MCHS_PKG_SRCURL=https://github.com/cernekee/stoken/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=9b9c5e0f09ca14a54454319b64af98a02d0ae1b3eb1122c95e2130736f440cd1
MCHS_PKG_DEPENDS="libnettle, libxml2"

mchs_step_pre_configure() {
	autoreconf -fi
}

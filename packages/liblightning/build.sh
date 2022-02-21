MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/lightning/
MCHS_PKG_DESCRIPTION="A library to aid in making portable programs that compile assembly code at run time"
MCHS_PKG_LICENSE="GPL-3.0, LGPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.1.3
MCHS_PKG_SRCURL=https://ftp.gnu.org/gnu/lightning/lightning-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ed856b866dc6f68678dc1151579118fab1c65fad687cf847fc2d94ca045efdc9
MCHS_PKG_DEPENDS="zlib"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_ffsl=yes
"

MCHS_PKG_HOMEPAGE=https://github.com/tgraf/bmon
MCHS_PKG_DESCRIPTION="Bandwidth monitor and rate estimator"
MCHS_PKG_LICENSE="MIT, BSD 2-Clause"
MCHS_PKG_LICENSE_FILE="LICENSE.MIT, LICENSE.BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.0
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/tgraf/bmon/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=d5e503ff6b116c681ebf4d10e238604dde836dceb9c0008eb92416a96c87ca40
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libconfuse, libnl, ncurses"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	./autogen.sh
}

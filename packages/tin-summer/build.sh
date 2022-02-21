MCHS_PKG_HOMEPAGE=https://github.com/vmchale/tin-summer
MCHS_PKG_DESCRIPTION="Find build artifacts that are taking up disk space"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.21.14
MCHS_PKG_SRCURL=https://github.com/vmchale/tin-summer/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=8a4883b7a6354c6340e73a87d1009c0cc79bdfa135fe947317705dad9f0a6727
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	sed -i 's/linux/android/g' src/utils.rs
}

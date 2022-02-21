MCHS_PKG_HOMEPAGE=http://landley.net/toybox/
MCHS_PKG_DESCRIPTION="Common Linux command line utilities"
MCHS_PKG_VERSION=0.7.3
MCHS_PKG_SRCURL=http://landley.net/toybox/downloads/toybox-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=e6469b508224e0d2e4564dda05c4bb47aef5c28bf29d6c983bcdc6e3a0cd29d6
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
	make defconfig
}

MCHS_PKG_HOMEPAGE=https://github.com/JuliaLang/utf8proc
MCHS_PKG_DESCRIPTION="Library for processing UTF-8 Unicode data"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.7.0
MCHS_PKG_SRCURL=https://github.com/JuliaLang/utf8proc/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=4bb121e297293c0fd55f08f83afab6d35d48f0af4ecc07523ad8ec99aa2b12a1
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BREAKS="utf8proc-dev"
MCHS_PKG_REPLACES="utf8proc-dev"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	rm $MCHS_PKG_SRCDIR/CMakeLists.txt
}

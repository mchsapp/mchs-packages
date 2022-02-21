MCHS_PKG_HOMEPAGE=https://www.linuxfromscratch.org/blfs/view/svn/general/popt.html
MCHS_PKG_DESCRIPTION="Library for parsing cmdline parameters"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.18
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://deb.debian.org/debian/pool/main/p/popt/popt_${MCHS_PKG_VERSION}.orig.tar.gz
MCHS_PKG_SHA256=5159bc03a20b28ce363aa96765f37df99ea4d8850b1ece17d1e6ad5c24fdc5d1
MCHS_PKG_DEPENDS="libandroid-glob"
MCHS_PKG_BREAKS="libpopt-dev"
MCHS_PKG_REPLACES="libpopt-dev"

mchs_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}

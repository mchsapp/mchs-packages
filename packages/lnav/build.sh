MCHS_PKG_HOMEPAGE=https://lnav.org/
MCHS_PKG_DESCRIPTION="An advanced log file viewer for the small-scale"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.10.1
MCHS_PKG_SRCURL=https://github.com/tstack/lnav/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=4af855a463493105ae0746fc0da80304a689b5394eb6abfeede4dd843127c8bc
MCHS_PKG_DEPENDS="libandroid-glob, libarchive, libbz2, libcurl, ncurses, pcre, readline, sqlite, zlib"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-system-paths
ac_cv_header_execinfo_h=no
"

mchs_step_pre_configure() {
	autoreconf -fi

	CPPFLAGS+=" -D_PATH_VARTMP=\\\"$MCHS_PREFIX/tmp\\\""
	LDFLAGS+=" -landroid-glob"
}

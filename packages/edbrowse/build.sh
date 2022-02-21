MCHS_PKG_HOMEPAGE=https://edbrowse.org/
MCHS_PKG_DESCRIPTION="Line based editor, browser, and mail client"
MCHS_PKG_LICENSE="GPL-3.0-or-later, MIT, MPL-2.0"
MCHS_PKG_LICENSE_FILE="../COPYING"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.8.0
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://github.com/CMB/edbrowse/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=5d512b63ee69e418e5946557ebc703c19e6dccc515f358649a2d38063a6d6a69
MCHS_PKG_DEPENDS="libandroid-glob, libcurl, pcre2, readline, tidy"
MCHS_PKG_BUILD_DEPENDS="quickjs"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	MCHS_PKG_SRCDIR="$MCHS_PKG_SRCDIR/src"
}

mchs_step_make_install() {
	install -Dm755 -t ${MCHS_PREFIX}/bin src/edbrowse
}

MCHS_PKG_HOMEPAGE=https://github.com/shellinabox/shellinabox
MCHS_PKG_DESCRIPTION="Implementation of a web server that can export arbitrary command line tools to a web based terminal emulator"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.20
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/shellinabox/shellinabox/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=27a5ec6c3439f87aee238c47cc56e7357a6249e5ca9ed0f044f0057ef389d81e
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="openssl, openssl-tool, mchs-auth (>= 1.2), zlib"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--enable-login
--disable-pam
--disable-utmp
--disable-runtime-loading
"

mchs_step_pre_configure() {
	export LIBS="-lssl -lcrypto"
	autoreconf -i
}

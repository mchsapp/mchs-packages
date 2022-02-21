MCHS_PKG_HOMEPAGE=https://newsboat.org/
MCHS_PKG_DESCRIPTION="RSS/Atom feed reader for the text console"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.24
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://newsboat.org/releases/${MCHS_PKG_VERSION}/newsboat-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=62420688cca25618859548d10ff6df9ac75b9cf766699f37edd3e324d67c6ffb
MCHS_PKG_DEPENDS="libc++, libiconv, libandroid-support, libandroid-glob, json-c, libsqlite, libcurl, libxml2, stfl, ncurses, openssl"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_RM_AFTER_INSTALL="share/locale"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_bsd_main=no"
MCHS_PKG_CONFLICTS=newsbeuter
MCHS_PKG_REPLACES=newsbeuter

mchs_step_pre_configure() {
	mchs_setup_rust

	export CXX_FOR_BUILD=g++
	export CXXFLAGS_FOR_BUILD="-O2"

	# Used by newsboat Makefile:
	export CARGO_BUILD_TARGET=$CARGO_TARGET_NAME

	LDFLAGS+=" -liconv"

	export PKG_CONFIG_ALLOW_CROSS=1
}

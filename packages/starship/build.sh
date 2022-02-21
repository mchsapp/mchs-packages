MCHS_PKG_HOMEPAGE=https://starship.rs
MCHS_PKG_DESCRIPTION="A minimal, blazing fast, and extremely customizable prompt for any shell"
MCHS_PKG_LICENSE="ISC"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.58.0
MCHS_PKG_SRCURL=https://github.com/starship/starship/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=8bd4cfad4bcf9694633f228de0c7dc6cfab6bb6955e2a7299ed28dd8c4d6f5e4
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="zlib, openssl"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--no-default-features --features http"
MCHS_PKG_BLACKLISTED_ARCHES="x86_64"

mchs_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	if [ $MCHS_ARCH = arm ]; then
		CFLAGS+=" -fno-integrated-as"
	fi
}

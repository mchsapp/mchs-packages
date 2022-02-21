MCHS_PKG_HOMEPAGE=https://jcorporation.github.io/myMPD/
MCHS_PKG_DESCRIPTION="A standalone and lightweight web-based MPD client"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=8.1.6
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/jcorporation/myMPD/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=eddeec8e598aca50e47d6da7f09103f2772d763abb65df7da2599013056a00ef
MCHS_PKG_DEPENDS="libflac, libid3tag, openssl, pcre, resolv-conf"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	CFLAGS+=" -I$MCHS_PKG_SRCDIR/release"

	ln -sfT ../dist src/dist
	sh build.sh createassets
	cd release
}

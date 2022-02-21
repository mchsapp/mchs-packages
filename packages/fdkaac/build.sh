MCHS_PKG_HOMEPAGE=https://github.com/nu774/fdkaac
MCHS_PKG_DESCRIPTION="command line encoder frontend for libfdk-aac"
MCHS_PKG_LICENSE="ZLIB"
MCHS_PKG_MAINTAINER="@DLC01"
MCHS_PKG_VERSION=1.0.2
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/nu774/fdkaac/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=8a0b67792605fb8955d6be78a81e3a4029e9b7d0f594d8ed76e0fbcef90be0c8
MCHS_PKG_DEPENDS="libfdk-aac"

mchs_step_pre_configure() {
	autoreconf -fi
}

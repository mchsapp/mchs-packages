MCHS_PKG_HOMEPAGE=https://github.com/radare/ired
MCHS_PKG_DESCRIPTION="Minimalist hexadecimal editor"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.6
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/radare/ired/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=c15d37b96b1a25c44435d824bd7ef1f9aea9dc191be14c78b689d3156312d58a
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	CFLAGS+=" $LDFLAGS"
}

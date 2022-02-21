MCHS_PKG_HOMEPAGE=http://www.digip.org/jansson/
MCHS_PKG_DESCRIPTION="C library for encoding, decoding and manipulating JSON data"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.14
MCHS_PKG_SRCURL=https://github.com/akheron/jansson/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=c739578bf6b764aa0752db9a2fdadcfe921c78f1228c7ec0bb47fa804c55d17b
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BREAKS="libjansson-dev"
MCHS_PKG_REPLACES="libjansson-dev"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	autoreconf -fi
}

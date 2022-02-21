MCHS_PKG_HOMEPAGE=https://www.opus-codec.org/
MCHS_PKG_DESCRIPTION="A high-level API for decoding and seeking within .opus files"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.12
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/xiph/opusfile/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=a20a1dff1cdf0719d1e995112915e9966debf1470ee26bb31b2f510ccf00ef40
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_DEPENDS="libopus, libogg"
MCHS_PKG_BREAKS="opusfile-dev"
MCHS_PKG_REPLACES="opusfile-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-http"

mchs_step_pre_configure() {
	echo "PACKAGE_VERSION=$MCHS_PKG_VERSION" > package_version
	./autogen.sh
}

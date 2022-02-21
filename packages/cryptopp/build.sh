MCHS_PKG_HOMEPAGE=https://www.cryptopp.com/
MCHS_PKG_DESCRIPTION="A free C++ class library of cryptographic schemes"
MCHS_PKG_LICENSE="BSL-1.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=8.6.0
MCHS_PKG_SRCURL=https://github.com/weidai11/cryptopp/archive/refs/tags/CRYPTOPP_${MCHS_PKG_VERSION//./_}.tar.gz
MCHS_PKG_SHA256=9304625f4767a13e0a5f26d0f019d78cf9375604a33e5391c3bf2e81399dfeb8
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+.\d+.\d+"
MCHS_PKG_BREAKS="cryptopp-dev"
MCHS_PKG_REPLACES="cryptopp-dev"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_MAKE_INSTALL_TARGET="install-lib"

MCHS_PKG_RM_AFTER_INSTALL="
bin/
share/cryptopp/
"

mchs_step_pre_configure() {
	export CXXFLAGS+=" -fPIC -DCRYPTOPP_DISABLE_ASM"
	export MCHS_PKG_EXTRA_MAKE_ARGS+=" dynamic libcryptopp.pc CC=$CC CXX=$CXX"
}

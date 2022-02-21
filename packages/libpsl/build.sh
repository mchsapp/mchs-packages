MCHS_PKG_HOMEPAGE=https://github.com/rockdaboot/libpsl
MCHS_PKG_DESCRIPTION="Public Suffix List library"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.21.1
MCHS_PKG_SRCURL=https://github.com/rockdaboot/libpsl/releases/download/${MCHS_PKG_VERSION}/libpsl-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ac6ce1e1fbd4d0254c4ddb9d37f1fa99dec83619c1253328155206b896210d4c
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libidn2, libunistring"
MCHS_PKG_BREAKS="libpsl-dev"
MCHS_PKG_REPLACES="libpsl-dev"

mchs_step_pre_configure() {
	autoreconf -fiv
}

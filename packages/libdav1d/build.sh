MCHS_PKG_HOMEPAGE=https://code.videolan.org/videolan/dav1d/
MCHS_PKG_DESCRIPTION="AV1 cross-platform decoder focused on speed and correctness"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.9.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://downloads.videolan.org/pub/videolan/dav1d/${MCHS_PKG_VERSION}/dav1d-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=e3235ab6c43c0135b0db1d131e1923fad4c84db9d85683e30b91b33a52d61c71
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-Denable_tools=false
-Denable_tests=false
"

mchs_step_pre_configure() {
	if [ "$MCHS_ARCH" = "i686" ]; then
		# Avoid text relocations.
		MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" -Denable_asm=false"
	fi
}

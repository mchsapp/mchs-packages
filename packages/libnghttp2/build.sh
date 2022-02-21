MCHS_PKG_HOMEPAGE=https://nghttp2.org/
MCHS_PKG_DESCRIPTION="nghttp HTTP 2.0 library"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.46.0
MCHS_PKG_SRCURL=https://github.com/nghttp2/nghttp2/releases/download/v${MCHS_PKG_VERSION}/nghttp2-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=1a68cc4a5732afb735baf50aaac3cb3a6771e49f744bd5db6c49ab5042f12a43
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BREAKS="libnghttp2-dev"
MCHS_PKG_REPLACES="libnghttp2-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--enable-lib-only"
# The tools are not built due to --enable-lib-only:
MCHS_PKG_RM_AFTER_INSTALL="share/man/man1 share/nghttp2/fetch-ocsp-response"

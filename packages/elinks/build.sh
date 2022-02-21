MCHS_PKG_HOMEPAGE=https://github.com/rkd77/elinks
MCHS_PKG_DESCRIPTION="Full-Featured Text WWW Browser"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.15.0
MCHS_PKG_SRCURL=https://github.com/rkd77/elinks/releases/download/v${MCHS_PKG_VERSION}/elinks-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=bf2e9d752921f2d83a7dcac1062c37ae6c8d7c4057d8537abe1c42fbac946fb3
MCHS_PKG_DEPENDS="libexpat, libiconv, libidn, openssl, libbz2, zlib"
MCHS_PKG_AUTO_UPDATE=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--enable-256-colors
--enable-true-color
--mandir=$MCHS_PREFIX/share/man
--with-openssl
--without-brotli
--without-zstd
--without-gc
"

MCHS_MAKE_PROCESSES=1

mchs_step_pre_configure() {
    ./autogen.sh
}

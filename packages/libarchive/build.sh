MCHS_PKG_HOMEPAGE=https://www.libarchive.org/
MCHS_PKG_DESCRIPTION="Multi-format archive and compression library"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.5.3
MCHS_PKG_SRCURL=https://github.com/libarchive/libarchive/releases/download/v$MCHS_PKG_VERSION/libarchive-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=72788e5f58d16febddfa262a5215e05fc9c79f2670f641ac039e6df44330ef51
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libbz2, libiconv, liblzma, libxml2, openssl, zlib"
MCHS_PKG_BREAKS="libarchive-dev"
MCHS_PKG_REPLACES="libarchive-dev"

# --without-nettle to use openssl instead:
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--without-nettle
--without-lz4
--without-zstd
--disable-acl
--disable-xattr
"

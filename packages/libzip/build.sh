MCHS_PKG_HOMEPAGE=https://libzip.org/
MCHS_PKG_DESCRIPTION="Library for reading, creating, and modifying zip archives"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.8.0
MCHS_PKG_SRCURL=https://github.com/nih-at/libzip/releases/download/v$MCHS_PKG_VERSION/libzip-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=30ee55868c0a698d3c600492f2bea4eb62c53849bcf696d21af5eb65f3f3839e
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libbz2, openssl, zlib"
MCHS_PKG_BREAKS="libzip-dev"
MCHS_PKG_REPLACES="libzip-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_GNUTLS=NO
-DENABLE_MBEDTLS=NO
-DENABLE_OPENSSL=YES
"

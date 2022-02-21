MCHS_PKG_HOMEPAGE=https://fukuchi.org/works/qrencode/
MCHS_PKG_DESCRIPTION="Fast and compact library for encoding data in a QR Code symbol"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="Henrik Grimler @Grimler91"
MCHS_PKG_VERSION=4.1.1
MCHS_PKG_SRCURL=https://github.com/fukuchi/libqrencode/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=5385bc1b8c2f20f3b91d258bf8ccc8cf62023935df2d2676b5b67049f31a049c
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libandroid-support, libpng, zlib"
MCHS_PKG_BREAKS="libqrencode-dev"
MCHS_PKG_REPLACES="libqrencode-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_SHARED_LIBS=ON"

MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/libiconv/
MCHS_PKG_DESCRIPTION="An implementation of iconv()"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.16
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://ftp.gnu.org/pub/gnu/libiconv/libiconv-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=e6a1b1b589654277ee790cce3734f07876ac4ccfaecbee8afa0b649cf529cc04
MCHS_PKG_BREAKS="libandroid-support (<= 24), libiconv-dev, libandroid-support-dev"
MCHS_PKG_REPLACES="libandroid-support (<= 24), libiconv-dev, libandroid-support-dev"

# Enable extra encodings (such as CP437) needed by some programs:
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--enable-extra-encodings"

MCHS_PKG_HOMEPAGE=https://libjpeg-turbo.virtualgl.org
MCHS_PKG_DESCRIPTION="Library for reading and writing JPEG image files"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.1.1
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/project/libjpeg-turbo/${MCHS_PKG_VERSION}/libjpeg-turbo-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=b76aaedefb71ba882cbad4e9275b30c2ae493e3195be0a099425b5c6b99bd510
MCHS_PKG_BREAKS="libjpeg-turbo-dev"
MCHS_PKG_REPLACES="libjpeg-turbo-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DWITH_JPEG8=1"

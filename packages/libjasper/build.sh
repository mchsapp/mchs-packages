MCHS_PKG_HOMEPAGE=http://www.ece.uvic.ca/~frodo/jasper/
MCHS_PKG_DESCRIPTION="Library for manipulating JPEG-2000 files"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.0.33
MCHS_PKG_SRCURL=https://github.com/mdadams/jasper/archive/version-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=38b8f74565ee9e7fec44657e69adb5c9b2a966ca5947ced5717cde18a7d2eca6
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+\.\d+\.\d+"
MCHS_PKG_DEPENDS="libjpeg-turbo"
MCHS_PKG_BREAKS="libjasper-dev"
MCHS_PKG_REPLACES="libjasper-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-H$MCHS_PKG_SRCDIR
-B$MCHS_PKG_BUILDDIR
"
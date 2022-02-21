MCHS_PKG_HOMEPAGE=https://gegl.org/babl/
MCHS_PKG_DESCRIPTION="Dynamic pixel format translation library"
MCHS_PKG_LICENSE="LGPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.1.88
MCHS_PKG_SRCURL=https://download.gimp.org/pub/babl/0.1/babl-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=4f0d7f4aaa0bb2e725f349adf7b351a957d9fb26d555d9895a7af816b4167039
MCHS_PKG_DEPENDS="littlecms"
MCHS_PKG_BREAKS="babl-dev"
MCHS_PKG_REPLACES="babl-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-Denable-gir=false"

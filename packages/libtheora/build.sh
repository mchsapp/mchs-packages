MCHS_PKG_HOMEPAGE=https://www.theora.org/
MCHS_PKG_DESCRIPTION="An open video codec developed by the Xiph.org"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.1.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://downloads.xiph.org/releases/theora/libtheora-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=b6ae1ee2fa3d42ac489287d3ec34c5885730b1296f0801ae577a35193d3affbc
MCHS_PKG_DEPENDS="libogg, libvorbis"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-examples"

MCHS_PKG_HOMEPAGE=https://www.musicpd.org/clients/mpc/
MCHS_PKG_DESCRIPTION="Minimalist command line interface for MPD"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.34
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://www.musicpd.org/download/mpc/${MCHS_PKG_VERSION:0:1}/mpc-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=691e3f3654bc10d022bb0310234d0bc2d8c075a698f09924d9ebed8f506fda20
MCHS_PKG_DEPENDS="libiconv, libmpdclient"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-Diconv=enabled"

# There seems to be issues with sphinx-build when using concurrent builds:
MCHS_MAKE_PROCESSES=1

mchs_step_pre_configure() {
	LDFLAGS+=" -liconv"
}

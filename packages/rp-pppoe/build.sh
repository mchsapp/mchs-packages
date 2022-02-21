MCHS_PKG_HOMEPAGE=https://dianne.skoll.ca/projects/rp-pppoe/
MCHS_PKG_DESCRIPTION="A PPP-over-Ethernet redirector for pppd"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.15
#MCHS_PKG_SRCURL=https://dianne.skoll.ca/projects/rp-pppoe/download/rp-pppoe-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SRCURL=https://fossies.org/linux/misc/rp-pppoe-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=b1f318bc7e4e5b0fd8a8e23e8803f5e6e43165245a5a10a7162a92a6cf17829a
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	MCHS_PKG_SRCDIR=$MCHS_PKG_SRCDIR/src
	MCHS_PKG_BUILDDIR=$MCHS_PKG_SRCDIR
}

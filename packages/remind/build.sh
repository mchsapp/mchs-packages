MCHS_PKG_HOMEPAGE=https://dianne.skoll.ca/projects/remind/
MCHS_PKG_DESCRIPTION="Sophisticated calendar and alarm program"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1:03.03.12
MCHS_PKG_SRCURL=https://fossies.org/linux/misc/remind-${MCHS_PKG_VERSION:2}.tar.xz
MCHS_PKG_SHA256=2ace40e58b06de383b812073c0a20771d5a6583e2b94e10927454d385be45eec
MCHS_PKG_DEPENDS="libandroid-glob"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_RM_AFTER_INSTALL="bin/tkremind share/man/man1/tkremind.1 bin/cm2rem.tcl share/man/man1/cm2rem.1"

mchs_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}

MCHS_PKG_HOMEPAGE=https://www.spice-space.org/
MCHS_PKG_DESCRIPTION="SPICE protocol headers"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.14.3
MCHS_PKG_SRCURL=https://www.spice-space.org/download/releases/spice-protocol-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=f986e5bc2a1598532c4897f889afb0df9257ac21c160c083703ae7c8de99487a

mchs_step_post_make_install() {
      mv "${MCHS_PREFIX}"/share/pkgconfig/spice-protocol.pc \
      "${MCHS_PREFIX}"/lib/pkgconfig
}

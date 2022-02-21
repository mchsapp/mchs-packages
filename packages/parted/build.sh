MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/parted/
MCHS_PKG_DESCRIPTION="Versatile partition editor"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.4
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/parted/parted-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=e1298022472da5589b7f2be1d5ee3c1b66ec3d96dfbad03dc642afd009da5342
MCHS_PKG_DEPENDS="libiconv, libuuid, readline"
MCHS_PKG_BREAKS="parted-dev"
MCHS_PKG_REPLACES="parted-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-device-mapper
"

mchs_step_pre_configure() {
    CFLAGS+=" -Wno-gnu-designator"
    export LIBS="-liconv"
}

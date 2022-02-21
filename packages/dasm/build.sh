MCHS_PKG_HOMEPAGE=https://dasm-dillon.sourceforge.io/
MCHS_PKG_DESCRIPTION="Macro assembler with support for several 8-bit microprocessors"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.20.14.1
MCHS_PKG_SRCURL=https://github.com/dasm-assembler/dasm/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ec71ffd10eeaa70bf7587ee0d79a92cd3f0a017c0d6d793e37d10359ceea663a
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make_install() {
  cp $MCHS_PKG_SRCDIR/bin/* $MCHS_PREFIX/bin/
}

MCHS_PKG_HOMEPAGE=https://dev.lovelyhq.com/libburnia
MCHS_PKG_DESCRIPTION="Frontend for libraries libburn and libisofs"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.5.4
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=http://files.libburnia-project.org/releases/libisoburn-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=2d89846d43880f17fa591c53b3bea42ffb803628e4e630c680fc2c9184f79132
MCHS_PKG_DEPENDS="libburn, libisofs, readline"
MCHS_PKG_CONFLICTS="xorriso"
MCHS_PKG_BREAKS="libisoburn-dev"
MCHS_PKG_REPLACES="libisoburn-dev"

# We don't have tk.
MCHS_PKG_RM_AFTER_INSTALL="bin/xorriso-tcltk"

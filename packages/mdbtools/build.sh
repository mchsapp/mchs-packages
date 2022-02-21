MCHS_PKG_HOMEPAGE=https://github.com/mdbtools/mdbtools
MCHS_PKG_DESCRIPTION="A set of programs to help you extract data from Microsoft Access files in various settings"
MCHS_PKG_LICENSE="GPL-2.0, LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.0.0
MCHS_PKG_SRCURL=https://github.com/mdbtools/mdbtools/releases/download/v${MCHS_PKG_VERSION}/mdbtools-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=3446e1d71abdeb98d41e252777e67e1909b186496fda59f98f67032f7fbcd955
MCHS_PKG_DEPENDS="glib, libiconv, readline"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-iodbc=$MCHS_PREFIX"

MCHS_PKG_HOMEPAGE=http://www.tads.org/frobtads.htm
MCHS_PKG_DESCRIPTION="TADS is a free authoring system for writing your own Interactive Fiction"
MCHS_PKG_LICENSE="non-free"
MCHS_PKG_VERSION=2.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/realnc/frobtads/releases/download/v$MCHS_PKG_VERSION/frobtads-$MCHS_PKG_VERSION.tar.bz2
MCHS_PKG_SHA256=893bd3fd77dfdc8bfe8a96e8d7bfac693da0e4278871f10fe7faa59cc239a090
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_RM_AFTER_INSTALL="share/frobtads/tads3/doc share/frobtads/tads3/lib/webuires"
MCHS_PKG_DEPENDS="libc++, ncurses, libcurl"
MCHS_PKG_LICENSE_FILE="doc/COPYING"
MCHS_PKG_MAINTAINER="@mchs"

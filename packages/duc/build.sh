MCHS_PKG_HOMEPAGE=http://duc.zevv.nl/
MCHS_PKG_DESCRIPTION="High-performance disk usage analyzer"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.4.4
MCHS_PKG_REVISION=8
MCHS_PKG_SRCURL=https://github.com/zevv/duc/releases/download/$MCHS_PKG_VERSION/duc-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=f4e7483dbeca4e26b003548f9f850b84ce8859bba90da89c55a7a147636ba922
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="leveldb, ncurses"
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-x11
--with-db-backend=leveldb
--disable-cairo"

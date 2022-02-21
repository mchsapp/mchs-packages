MCHS_PKG_HOMEPAGE=http://libcddb.sourceforge.net/
MCHS_PKG_DESCRIPTION="A C library to access data on a CDDB server"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3.2
MCHS_PKG_SRCURL=http://prdownloads.sourceforge.net/libcddb/libcddb-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=35ce0ee1741ea38def304ddfe84a958901413aa829698357f0bee5bb8f0a223b
MCHS_PKG_DEPENDS="libiconv"

mchs_step_pre_configure() {
	autoreconf -fi
}

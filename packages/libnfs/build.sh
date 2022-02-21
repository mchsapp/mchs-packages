MCHS_PKG_HOMEPAGE=https://github.com/sahlberg/libnfs
MCHS_PKG_DESCRIPTION="NFS client library"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.0.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/sahlberg/libnfs/archive/libnfs-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=6ee77e9fe220e2d3e3b1f53cfea04fb319828cc7dbb97dd9df09e46e901d797d
MCHS_PKG_BREAKS="libnfs-dev"
MCHS_PKG_REPLACES="libnfs-dev"

mchs_step_pre_configure() {
	autoreconf -fi
}

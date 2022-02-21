MCHS_PKG_HOMEPAGE=https://github.com/thom311/libnl
MCHS_PKG_DESCRIPTION="Collection of libraries providing APIs to netlink protocol based Linux kernel interfaces"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.5.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/thom311/libnl/releases/download/libnl${MCHS_PKG_VERSION//./_}/libnl-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=352133ec9545da76f77e70ccb48c9d7e5324d67f6474744647a7ed382b5e05fa
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+.\d+.\d+"
MCHS_PKG_BREAKS="libnl-dev"
MCHS_PKG_REPLACES="libnl-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-pthreads --disable-cli"

mchs_step_pre_configure() {
	CFLAGS+=" -Dsockaddr_storage=__kernel_sockaddr_storage"
}

MCHS_PKG_HOMEPAGE=https://www.tcpdump.org
MCHS_PKG_DESCRIPTION="Library for network traffic capture"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.10.1
MCHS_PKG_SRCURL=https://fossies.org/linux/misc/libpcap-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=4315eb4a764fd3cb89938cc394116ff31483d0d29d71ec1a42c25bfd2aad1ed6
MCHS_PKG_BREAKS="libpcap-dev"
MCHS_PKG_REPLACES="libpcap-dev"
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-pcap=linux --without-libnl"
MCHS_PKG_RM_AFTER_INSTALL="bin/pcap-config share/man/man1/pcap-config.1"

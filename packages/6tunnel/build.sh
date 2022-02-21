MCHS_PKG_HOMEPAGE=https://github.com/wojtekka/6tunnel
MCHS_PKG_DESCRIPTION="Allows you to use services provided by IPv6 hosts with IPv4-only applications and vice-versa"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.13
MCHS_PKG_SRCURL=https://github.com/wojtekka/6tunnel/archive/refs/tags/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=9f15ae24116ab2e781dc5a73faf9bb699b694cf845c9122ea755ab1780751f01

mchs_step_pre_configure() {
	autoreconf -fi
}

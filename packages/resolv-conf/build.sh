MCHS_PKG_HOMEPAGE=https://man7.org/linux/man-pages/man5/resolv.conf.5.html
MCHS_PKG_DESCRIPTION="Resolver configuration file"
MCHS_PKG_LICENSE="Public Domain"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3
MCHS_PKG_SKIP_SRC_EXTRACT=true

MCHS_PKG_CONFFILES="
etc/hosts
etc/resolv.conf
"

mchs_step_make_install() {
	printf "127.0.0.1 localhost\n::1 ip6-localhost\n" > $MCHS_PREFIX/etc/hosts
	printf "nameserver 8.8.8.8\nnameserver 8.8.4.4\n" > $MCHS_PREFIX/etc/resolv.conf
}

MCHS_PKG_HOMEPAGE=https://github.com/resurrecting-open-source-projects/dnsmap
MCHS_PKG_DESCRIPTION="Subdomain Bruteforcing Tool"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.36
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/resurrecting-open-source-projects/dnsmap/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=f52d6d49cbf9a60f601c919f99457f108d51ecd011c63e669d58f38d50ad853c
MCHS_PKG_AUTO_UPDATE=true

mchs_step_pre_configure() {
	./autogen.sh
}

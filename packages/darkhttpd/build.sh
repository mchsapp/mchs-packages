MCHS_PKG_HOMEPAGE=https://unix4lyfe.org/darkhttpd
MCHS_PKG_DESCRIPTION="A simple webserver, implemented in a single .c file."
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="David Paskevic @casept"
MCHS_PKG_VERSION=1.13
MCHS_PKG_SRCURL=https://github.com/emikulic/darkhttpd/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=1d88c395ac79ca9365aa5af71afe4ad136a4ed45099ca398168d4a2014dc0fc2
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	CFLAGS+=" $LDFLAGS"
}

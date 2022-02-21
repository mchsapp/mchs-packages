MCHS_PKG_HOMEPAGE="https://github.com/nelhage/reptyr"
MCHS_PKG_DESCRIPTION="Tool for reparenting a running program to a new terminal"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.8.0
MCHS_PKG_SRCURL=https://github.com/nelhage/reptyr/archive/refs/tags/reptyr-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=4b470ed2a0d25fed591739fa9613ce7ad3d0377891eb56cbe914e3c85db46ca8
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make_install() {
	install -Dm700 -t ${MCHS_PREFIX}/bin reptyr
	install -Dm600 -t ${MCHS_PREFIX}/share/man/man1 ${MCHS_PKG_SRCDIR}/reptyr.1
}

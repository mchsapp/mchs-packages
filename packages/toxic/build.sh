MCHS_PKG_HOMEPAGE=https://github.com/JFreegman/toxic
MCHS_PKG_DESCRIPTION="A command line client for Tox"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.11.3
MCHS_PKG_SRCURL=https://github.com/JFreegman/toxic/archive/v${MCHS_PKG_VERSION}/toxic-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=1a3fd4289852bf64ee17b98a27597d0d8f5e7d3c9ac90180bd4e63a8e5ae53d9
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="c-toxcore, libconfig, libcurl, libqrencode, ncurses, zlib"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	make \
		PREFIX="${MCHS_PREFIX}" \
		CC="${CC}" \
		PKG_CONFIG="${PKG_CONFIG}" \
		USER_CFLAGS="${CFLAGS}" \
		USER_LDFLAGS="${LDFLAGS}"
}

mchs_step_make_install() {
	make PREFIX="${MCHS_PREFIX}" install
}

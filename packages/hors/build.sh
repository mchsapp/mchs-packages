MCHS_PKG_HOMEPAGE=https://github.com/WindSoilder/hors
MCHS_PKG_DESCRIPTION="Instant coding answers via the command line (howdoi in rust)"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="Krishna Kanhaiya @kcubeterm"
MCHS_PKG_VERSION=0.8.2
MCHS_PKG_SRCURL=https://github.com/WindSoilder/hors/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=22419b26f64a2793759d3a3616df58196897cd9227074f475aeb3e1c366296a9
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	if [ $MCHS_ARCH = arm ]; then
		CFLAGS+=" -fno-integrated-as"
	fi

	rm -f Makefile
}

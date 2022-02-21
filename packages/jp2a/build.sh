MCHS_PKG_HOMEPAGE=https://csl.name/jp2a/
MCHS_PKG_DESCRIPTION="A simple JPEG to ASCII converter"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.1.1
MCHS_PKG_SRCURL=https://github.com/Talinx/jp2a/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=332521cd4675b4a03c7080a600ccbd848eb29aebf17fce767f163d8dac141555
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libcurl, libjpeg-turbo, libpng, ncurses"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	autoreconf -vi
}

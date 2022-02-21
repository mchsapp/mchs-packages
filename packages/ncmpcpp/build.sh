MCHS_PKG_HOMEPAGE=https://rybczak.net/ncmpcpp/
MCHS_PKG_DESCRIPTION="NCurses Music Player Client (Plus Plus)"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.9.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://rybczak.net/ncmpcpp/stable/ncmpcpp-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=faabf6157c8cb1b24a059af276e162fa9f9a3b9cd3810c43b9128860c9383a1b
MCHS_PKG_DEPENDS="fftw, boost, readline, libandroid-support, libc++, libcurl, libicu, libmpdclient, ncurses, zlib"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--enable-visualizer --enable-outputs --enable-clock"

mchs_step_pre_configure() {
	./autogen.sh
	CXXFLAGS+=" -DNCURSES_WIDECHAR -U_XOPEN_SOURCE"
}

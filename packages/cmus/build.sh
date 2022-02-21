MCHS_PKG_HOMEPAGE=https://cmus.github.io/
MCHS_PKG_DESCRIPTION="Small, fast and powerful console music player"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.9.1
MCHS_PKG_REVISION=1
MCHS_PKG_DEPENDS="libandroid-support, libiconv, ncurses, pulseaudio, ffmpeg, libmad, opusfile, libflac, libvorbis"
MCHS_PKG_SRCURL=https://github.com/cmus/cmus/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=6fb799cae60db9324f03922bbb2e322107fd386ab429c0271996985294e2ef44
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	LD=$CC
	export CUE_LIBS=" -lm"
	export CONFIG_OSS=n
}

mchs_step_configure() {
	./configure prefix=$MCHS_PREFIX
}

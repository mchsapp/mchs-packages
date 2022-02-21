MCHS_PKG_HOMEPAGE=https://github.com/karlstav/cava
MCHS_PKG_DESCRIPTION="Console-based Audio Visualizer. Works with MPD and Pulseaudio"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
MCHS_PKG_VERSION=0.7.4
MCHS_PKG_SRCURL=https://github.com/karlstav/cava/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=fefd3cc04d41b03ca416630cafadbfda6c75e2ca0869da1f03963dcb13e1ecb7
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="ncurses,fftw,pulseaudio"
MCHS_PKG_BUILD_DEPENDS="libtool"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	./autogen.sh
}

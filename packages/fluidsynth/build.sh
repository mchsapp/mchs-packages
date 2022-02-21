MCHS_PKG_HOMEPAGE=https://github.com/FluidSynth/fluidsynth
MCHS_PKG_DESCRIPTION="Software synthesizer based on the SoundFont 2 specifications"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="Yonle <yonle@protonmail.com>"
MCHS_PKG_VERSION=2.2.5
MCHS_PKG_SRCURL=https://github.com/FluidSynth/fluidsynth/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=9037e703617f91c4c36039a5059e0f624164799d856af715bcd8a23c07ba03b8
MCHS_PKG_DEPENDS="glib, pulseaudio"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DLIB_INSTALL_DIR=${MCHS_PREFIX}/lib"


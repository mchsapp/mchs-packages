MCHS_PKG_HOMEPAGE=https://lib.openmpt.org/libopenmpt/
MCHS_PKG_DESCRIPTION="OpenMPT based module player library and libopenmpt based command-line player"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.5.12
MCHS_PKG_SRCURL=https://lib.openmpt.org/files/libopenmpt/src/libopenmpt-${MCHS_PKG_VERSION}+release.autotools.tar.gz
MCHS_PKG_SHA256=892aea7a599b5d21842bebf463b5aafdad5711be7008dd84401920c6234820af
MCHS_PKG_DEPENDS="libflac, mpg123, pulseaudio"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--without-portaudio
--without-portaudiocpp
"

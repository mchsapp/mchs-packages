MCHS_PKG_HOMEPAGE=http://sox.sourceforge.net/
MCHS_PKG_DESCRIPTION="Command line utility for converting between and applying effects to various audio files formats"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=14.4.2
MCHS_PKG_REVISION=20
MCHS_PKG_SRCURL=http://downloads.sourceforge.net/project/sox/sox/${MCHS_PKG_VERSION}/sox-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=81a6956d4330e75b5827316e44ae381e6f1e8928003c6aa45896da9041ea149c
MCHS_PKG_DEPENDS="file, libao, libpng, libmp3lame, libvorbis, libandroid-glob, libflac, libid3tag, libmad, pulseaudio, opusfile, libsndfile, zlib"
MCHS_PKG_BREAKS="sox-dev"
MCHS_PKG_REPLACES="sox-dev"

mchs_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
	CPPFLAGS+=" -D_FSTDIO"
}

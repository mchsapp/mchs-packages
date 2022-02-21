MCHS_PKG_HOMEPAGE=https://github.com/xiph/vorbis-tools
MCHS_PKG_DESCRIPTION="Ogg Vorbis tools"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.4.2
MCHS_PKG_SRCURL=http://downloads.xiph.org/releases/vorbis/vorbis-tools-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=db7774ec2bf2c939b139452183669be84fda5774d6400fc57fde37f77624f0b0
# libflac for flac support in oggenc:
MCHS_PKG_DEPENDS="libiconv, libvorbis, libflac, libogg"

mchs_step_pre_configure() {
	LDFLAGS+=" -lm"
}

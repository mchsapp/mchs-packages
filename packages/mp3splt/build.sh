MCHS_PKG_HOMEPAGE=http://mp3splt.sourceforge.net
MCHS_PKG_DESCRIPTION="Utility to split mp3, ogg vorbis and FLAC files without decoding"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.6.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=http://prdownloads.sourceforge.net/mp3splt/mp3splt-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=3ec32b10ddd8bb11af987b8cd1c76382c48d265d0ffda53041d9aceb1f103baa
MCHS_PKG_DEPENDS="libmp3splt"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$MCHS_PREFIX/share/man"

mchs_step_post_configure() {
	cd $MCHS_PKG_SRCDIR/src
	sed -i -e 's/BEOS/ANDROID/g' freedb.c
	touch langinfo.h
}

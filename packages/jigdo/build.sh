MCHS_PKG_HOMEPAGE=http://atterer.org/jigdo/
MCHS_PKG_DESCRIPTION="Distribute large images by sending and receiving the files that make them up"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.8.1
MCHS_PKG_SRCURL=https://www.einval.com/~steve/software/jigdo/download/jigdo-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=b1f08c802dd7977d90ea809291eb0a63888b3984cc2bf4c920ecc2a1952683da
MCHS_PKG_DEPENDS="libbz2, libc++, libdb, wget, zlib"
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--mandir=$MCHS_PREFIX/share/man
--without-gui
"

mchs_step_pre_configure() {
	# Should prevent random failures on installation step.
	export MCHS_MAKE_PROCESSES=1
}

MCHS_PKG_HOMEPAGE=http://www.graphicsmagick.org/
MCHS_PKG_DESCRIPTION="Collection of image processing tools"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3.36
MCHS_PKG_REVISION=1
# Bandwith limited on main ftp site, so it's asked to use sourceforge instead:
MCHS_PKG_SRCURL=http://downloads.sourceforge.net/project/graphicsmagick/graphicsmagick/${MCHS_PKG_VERSION}/GraphicsMagick-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=5d5b3fde759cdfc307aaf21df9ebd8c752e3f088bb051dd5df8aac7ba7338f46
MCHS_PKG_DEPENDS="littlecms, libc++, libtiff, freetype, libjasper, libjpeg-turbo, libpng, libbz2, libxml2, liblzma, zstd, zlib"
MCHS_PKG_BREAKS="graphicsmagick-dev"
MCHS_PKG_REPLACES="graphicsmagick++, graphicsmagick-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_ftime=no
--with-fontpath=/system/fonts
--without-webp
--without-x
"

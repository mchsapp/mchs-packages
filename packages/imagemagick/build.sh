MCHS_PKG_HOMEPAGE=https://www.imagemagick.org/
MCHS_PKG_DESCRIPTION="Suite to create, edit, compose, or convert images in a variety of formats"
MCHS_PKG_LICENSE="ImageMagick"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=7.1.0.16
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/ImageMagick/ImageMagick/archive/refs/tags/$(echo $MCHS_PKG_VERSION | sed 's/\(.*\)\./\1-/').tar.gz
MCHS_PKG_SHA256=6eec33290655c403af7ed41569e1c9a9d1c29f41df51b1a83207e5da8ef90b61
MCHS_PKG_DEPENDS="fftw, fontconfig, freetype, fribidi, glib, harfbuzz, libandroid-support, libbz2, libcairo, libffi, libgraphite, libheif, libjpeg-turbo, libjxl, liblzma, libpixman, libpng, librsvg, libtiff, libuuid, libwebp, libx11, libxau, libxcb, libxdmcp, libxext, libxml2, littlecms, openjpeg, pango, pcre, zlib, zstd"
MCHS_PKG_BREAKS="imagemagick-dev, imagemagick-x"
MCHS_PKG_REPLACES="imagemagick-dev, imagemagick-x"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--with-x
--without-gvc
--with-magick-plus-plus=yes
--with-bzlib=yes
--with-xml=yes
--with-rsvg=yes
--with-lzma
--with-jxl=yes
--with-fftw
--disable-openmp
ac_cv_func_ftime=no
"

MCHS_PKG_RM_AFTER_INSTALL="
share/ImageMagick-7/francais.xml
"

mchs_step_pre_configure() {
	if [ $MCHS_ARCH = "i686" ]; then
		#Avoid "libMagickCore-7.Q16HDRI.so: error: undefined reference to '__atomic_load'"
		LDFLAGS+=" -latomic"
	fi
}

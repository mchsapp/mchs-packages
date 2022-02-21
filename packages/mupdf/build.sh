MCHS_PKG_HOMEPAGE=https://mupdf.com/
MCHS_PKG_DESCRIPTION="Lightweight PDF and XPS viewer (library)"
MCHS_PKG_LICENSE="AGPL-V3"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.19.0
MCHS_PKG_SRCURL=https://mupdf.com/downloads/archive/mupdf-${MCHS_PKG_VERSION}-source.tar.xz
MCHS_PKG_SHA256=38f39943e408d60a3e7d6c2fca0d705163540ca24d65682d4426dc6f1fee28c5
MCHS_PKG_DEPENDS="freetype, gumbo-parser, harfbuzz, jbig2dec, libjpeg-turbo, openjpeg, tesseract, zlib"
MCHS_PKG_EXTRA_MAKE_ARGS="prefix=$MCHS_PREFIX build=release libs shared=yes tesseract=yes"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	if [ $MCHS_ARCH = "i686" ]; then
		MCHS_PKG_EXTRA_MAKE_ARGS="${MCHS_PKG_EXTRA_MAKE_ARGS/tesseract=yes/}"
	fi
	rm -rf thirdparty/{freeglut,freetype,harfbuzz,jbig2dec,leptonica,libjpeg,openjpeg,tesseract,zlib}
	export USE_SYSTEM_LIBS=yes
	LDFLAGS+=" -llog"
}

mchs_step_post_make_install() {
	MCHS_PKG_EXTRA_MAKE_ARGS="${MCHS_PKG_EXTRA_MAKE_ARGS/shared=yes/}"
	mchs_step_make
	install -Dm600 -t $MCHS_PREFIX/lib build/release*/libmupdf{-third,}.a
}

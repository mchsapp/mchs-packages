MCHS_PKG_HOMEPAGE=https://poppler.freedesktop.org/
MCHS_PKG_DESCRIPTION="PDF rendering library"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=21.08.0
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://poppler.freedesktop.org/poppler-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=e9cf5dc5964bce4bb0264d1c4f8122706c910588b421cfc30abc97d6b23e602d
MCHS_PKG_DEPENDS="fontconfig, freetype, glib, libc++, libcairo, libcurl, libiconv, libjpeg-turbo, libpng, libtiff, littlecms, openjpeg, openjpeg-tools, zlib"
MCHS_PKG_BUILD_DEPENDS="boost"
MCHS_PKG_BREAKS="poppler-dev"
MCHS_PKG_REPLACES="poppler-dev"
#texlive needs the xpdf headers
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_GLIB=ON
-DENABLE_UNSTABLE_API_ABI_HEADERS=ON
-DENABLE_QT5=OFF
-DFONT_CONFIGURATION=fontconfig
"

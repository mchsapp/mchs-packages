MCHS_PKG_HOMEPAGE=https://gegl.org/
MCHS_PKG_DESCRIPTION="Data flow based image processing framework"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.4.32
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://download.gimp.org/pub/gegl/${MCHS_PKG_VERSION:0:3}/gegl-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=668e3c6b9faf75fb00512701c36274ab6f22a8ba05ec62dbf187d34b8d298fa1
MCHS_PKG_DEPENDS="libandroid-support, libc++, ffmpeg, babl, json-glib, libjpeg-turbo, libpng, libjasper, littlecms, libtiff, librsvg, zlib"
MCHS_PKG_BREAKS="gegl-dev"
MCHS_PKG_REPLACES="gegl-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-Dintrospection=false"

# Disable ffmpeg support until fixed upstream:
# https://gitlab.gnome.org/GNOME/gegl/-/issues/301
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" -Dlibav=disabled"

MCHS_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/HarfBuzz/
MCHS_PKG_DESCRIPTION="OpenType text shaping engine"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.4.0
MCHS_PKG_SRCURL=https://github.com/harfbuzz/harfbuzz/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=810bcd3d22fae3c2c18c3688455abc1cd0d7fb2fae25404890b0d77e6443bd0a
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="freetype, glib, libbz2, libc++, libpng, libgraphite"
MCHS_PKG_BREAKS="harfbuzz-dev"
MCHS_PKG_REPLACES="harfbuzz-dev"
MCHS_PKG_BUILD_DEPENDS="libicu"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-Dgraphite=enabled"

mchs_step_post_get_source() {
	mv CMakeLists.txt CMakeLists.txt.unused
}

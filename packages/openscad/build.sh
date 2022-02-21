MCHS_PKG_HOMEPAGE=http://openscad.org/
MCHS_PKG_DESCRIPTION="The programmers solid 3D CAD modeller (headless build)"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2019.05
MCHS_PKG_REVISION=7
MCHS_PKG_SRCURL=https://files.openscad.org/openscad-$MCHS_PKG_VERSION.src.tar.gz
MCHS_PKG_SHA256=0a16c4263ce52380819dd91c609a719d38f12f6b8c4da0e828dcbe5b70996f59
MCHS_PKG_DEPENDS="boost, cgal, double-conversion, fontconfig, harfbuzz, libzip"
MCHS_PKG_BUILD_DEPENDS="eigen"
MCHS_PKG_GROUPS="science"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DBoost_USE_STATIC_LIBS=OFF
-DBUILD_SHARED_LIBS=ON
-DBUILD_STATIC_LIBS=OFF
-DNULLGL=ON
"

mchs_step_make_install () {
	mkdir -p $MCHS_PREFIX/share/openscad
	install openscad $MCHS_PREFIX/bin/
	cp -r $MCHS_PKG_SRCDIR/libraries $MCHS_PREFIX/share/openscad/
	cp -r $MCHS_PKG_SRCDIR/examples $MCHS_PREFIX/share/openscad/
}

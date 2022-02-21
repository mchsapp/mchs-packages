MCHS_PKG_HOMEPAGE=http://enblend.sourceforge.net/
MCHS_PKG_DESCRIPTION="A tool for compositing images using a Burt&Adelson multiresolution spline"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
_VERSION=4.2.0_p20161007
MCHS_PKG_VERSION=${_VERSION//_/}
MCHS_PKG_SRCURL=https://dev.gentoo.org/~soap/distfiles/enblend-${_VERSION}.tar.xz
MCHS_PKG_SHA256=4fe05af3d697bd6b2797facc8ba5aeabdc91e233156552301f1c7686232ff4c3
MCHS_PKG_DEPENDS="gsl, libandroid-glob, libc++, libtiff, libvigra, littlecms"
MCHS_PKG_BUILD_DEPENDS="boost, libjpeg-turbo, libpng, zlib"

mchs_step_pre_configure() {
	autoreconf -fi

	LDFLAGS+=" -landroid-glob"
}

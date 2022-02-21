MCHS_PKG_HOMEPAGE=https://timewarrior.net/
MCHS_PKG_DESCRIPTION="Command-line time tracker"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.4.2
MCHS_PKG_REVISION=1
_LIBSHARED_COMMIT=0d4e31de757ea2609a82549c5b09703d3d3fbe16
MCHS_PKG_SRCURL=(https://github.com/GothenburgBitFactory/timewarrior/archive/v${MCHS_PKG_VERSION}.tar.gz
		   https://github.com/GothenburgBitFactory/libshared/archive/${_LIBSHARED_COMMIT}.tar.gz)
MCHS_PKG_SHA256=(bedfa22af67fd382ea2d5d470b40079122474ba86482fb11ff06cec98bb1433c
		   c37f52fc39c62b3391a0eae061cef2c4079dfd4af0e3bdabac1be98316f9c451)
MCHS_PKG_DEPENDS="libandroid-glob, libc++"

mchs_step_post_get_source() {
	rmdir src/libshared
	mv libshared-${_LIBSHARED_COMMIT}/ src/libshared
}

mchs_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}


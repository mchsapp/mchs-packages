MCHS_PKG_HOMEPAGE=https://ninja-build.org
MCHS_PKG_DESCRIPTION="A small build system with a focus on speed"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.10.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/ninja-build/ninja/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ce35865411f0490368a8fc383f29071de6690cbadc27704734978221f25e2bed
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libc++, libandroid-spawn"

mchs_step_pre_configure() {
	CXXFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" -landroid-spawn"
}

mchs_step_configure() {
	$MCHS_PKG_SRCDIR/configure.py
}

mchs_step_make() {
	if $MCHS_ON_DEVICE_BUILD; then
		$MCHS_PKG_SRCDIR/configure.py --bootstrap
	else
		mchs_setup_ninja
		ninja -j $MCHS_MAKE_PROCESSES
	fi
}

mchs_step_make_install() {
	cp ninja $MCHS_PREFIX/bin
}

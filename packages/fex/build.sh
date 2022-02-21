MCHS_PKG_HOMEPAGE=https://wiki.fex-emu.org/index.php/Main_Page
MCHS_PKG_DESCRIPTION="Fast x86 emulation frontend"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2201
MCHS_PKG_SRCURL=https://github.com/FEX-Emu/FEX.git
MCHS_PKG_GIT_BRANCH=FEX-${MCHS_PKG_VERSION}
MCHS_PKG_DEPENDS="libandroid-shmem, libc++"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_TESTS=OFF
-DENABLE_LTO=OFF
-DENABLE_JEMALLOC=OFF
-DENABLE_OFFLINE_TELEMETRY=OFF
"
MCHS_PKG_BLACKLISTED_ARCHES="arm, i686, x86_64"

mchs_step_pre_configure() {
	LDFLAGS+=" -landroid-shmem"

	find $MCHS_PKG_SRCDIR -name '*.h' -o -name '*.c' -o -name '*.cpp' | \
		xargs -n 1 sed -i -e 's:"/tmp:"'$MCHS_PREFIX'/tmp:g'

	_NEED_DUMMY_LIBPTHREAD_A=
	_LIBPTHREAD_A=$MCHS_PREFIX/lib/libpthread.a
	if [ ! -e $_LIBPTHREAD_A ]; then
		_NEED_DUMMY_LIBPTHREAD_A=true
		echo '!<arch>' > $_LIBPTHREAD_A
	fi
}

mchs_step_post_make_install() {
	if [ $_NEED_DUMMY_LIBPTHREAD_A ]; then
		rm -f $_LIBPTHREAD_A
	fi
}


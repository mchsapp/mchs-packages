MCHS_PKG_HOMEPAGE=https://bladelang.com/
MCHS_PKG_DESCRIPTION="A simple, fast, clean and dynamic language"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.0.6
MCHS_PKG_SRCURL=https://github.com/blade-lang/blade/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=3c13f2a81dc027871993e8a369691a470ed7f62b9fb4a72237ff75db36abe35d
MCHS_PKG_DEPENDS="libsqlite, readline"
MCHS_PKG_HOSTBUILD=true

mchs_step_host_build() {
	mchs_setup_cmake
	cmake $MCHS_PKG_SRCDIR
	make -j $MCHS_MAKE_PROCESSES
}

mchs_step_pre_configure() {
	PATH=$MCHS_PKG_HOSTBUILD_DIR/bin:$PATH

	_NEED_DUMMY_LIBPTHREAD_A=
	_LIBPTHREAD_A=$MCHS_PREFIX/lib/libpthread.a
	if [ ! -e $_LIBPTHREAD_A ]; then
		_NEED_DUMMY_LIBPTHREAD_A=true
		echo '!<arch>' > $_LIBPTHREAD_A
	fi
}

mchs_step_make_install() {
	pushd bin
	install -Dm700 -t $MCHS_PREFIX/bin blade
	install -Dm600 -t $MCHS_PREFIX/lib libblade.so
	local sharedir=$MCHS_PREFIX/share/blade
	mkdir -p $sharedir
	cp -r benchmarks includes libs tests $sharedir/
	popd
}

mchs_step_post_make_install() {
	if [ $_NEED_DUMMY_LIBPTHREAD_A ]; then
		rm -f $_LIBPTHREAD_A
	fi
}

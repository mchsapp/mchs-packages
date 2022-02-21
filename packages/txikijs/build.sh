MCHS_PKG_HOMEPAGE=https://github.com/saghul/txiki.js
MCHS_PKG_DESCRIPTION="A small and powerful JavaScript runtime"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=ffa4b191eeb23984d502b183a1f521be717f1eb5
MCHS_PKG_VERSION=2021.11.16
MCHS_PKG_SRCURL=https://github.com/saghul/txiki.js.git
MCHS_PKG_GIT_BRANCH=master
MCHS_PKG_DEPENDS="libcurl"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_NATIVE=OFF"
MCHS_PKG_HOSTBUILD=true

# Build failure for i686:
#   [...]/txikijs/src/deps/wasm3/source/./extra/wasi_core.h:46:1:
#   fatal error: static_assert failed due to requirement
#   '__alignof(long long) == 8' "non-wasi data layout"
#   _Static_assert(_Alignof(int64_t) == 8, "non-wasi data layout");
#   ^              ~~~~~~~~~~~~~~~~~~~~~~
MCHS_PKG_BLACKLISTED_ARCHES="i686"

mchs_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$MCHS_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$MCHS_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi
}

mchs_step_host_build() {
	find $MCHS_PKG_SRCDIR -mindepth 1 -maxdepth 1 ! -name '.git*' \
		-exec cp -a \{\} ./ \;

	mchs_setup_cmake

	cmake .
	make -j $MCHS_MAKE_PROCESSES
}

mchs_step_pre_configure() {
	_NEED_DUMMY_LIBPTHREAD_A=
	_LIBPTHREAD_A=$MCHS_PREFIX/lib/libpthread.a
	if [ ! -e $_LIBPTHREAD_A ]; then
		_NEED_DUMMY_LIBPTHREAD_A=true
		echo '!<arch>' > $_LIBPTHREAD_A
	fi
	_NEED_DUMMY_LIBRT_A=
	_LIBRT_A=$MCHS_PREFIX/lib/librt.a
	if [ ! -e $_LIBRT_A ]; then
		_NEED_DUMMY_LIBRT_A=true
		echo '!<arch>' > $_LIBRT_A
	fi
}

mchs_step_post_configure() {
	export PATH=$MCHS_PKG_HOSTBUILD_DIR:$PATH
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin tjs
}

mchs_step_post_make_install() {
	if [ $_NEED_DUMMY_LIBPTHREAD_A ]; then
		rm -f $_LIBPTHREAD_A
	fi
	if [ $_NEED_DUMMY_LIBRT_A ]; then
		rm -f $_LIBRT_A
	fi
}

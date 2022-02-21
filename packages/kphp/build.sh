MCHS_PKG_HOMEPAGE=https://vkcom.github.io/kphp/
MCHS_PKG_DESCRIPTION="A PHP compiler"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=b1b2cec0f0e1206e1c134830ebd1f28e21bbd330
MCHS_PKG_VERSION=2021.12.30
MCHS_PKG_SRCURL=https://github.com/VKCOM/kphp.git
MCHS_PKG_GIT_BRANCH=master
MCHS_PKG_DEPENDS="fmt, libc++, libcurl, libmsgpack-cxx, libre2, libuber-h3, libucontext, libyaml-cpp, openssl, pcre, zstd"
MCHS_PKG_BUILD_DEPENDS="kphp-timelib"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DKPHP_TESTS=OFF"
MCHS_PKG_BLACKLISTED_ARCHES="arm, i686"

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

mchs_step_pre_configure() {
	_NEED_DUMMY_LIBPTHREAD_A=
	_LIBPTHREAD_A=$MCHS_PREFIX/lib/libpthread.a
	if [ ! -e $_LIBPTHREAD_A ]; then
		_NEED_DUMMY_LIBPTHREAD_A=true
		echo '!<arch>' > $_LIBPTHREAD_A
	fi
}

mchs_step_post_configure() {
	local f
	if [ "$MCHS_CMAKE_BUILD" == "Ninja" ]; then
		f=build.ninja
	else
		f=CMakeFiles/kphp2cpp.dir/link.txt
	fi
	sed -i -e 's/-l:libyaml-cpp\.a/-lyaml-cpp/g' \
		-e 's/-l:libre2\.a/-lre2/g' \
		$f

	local bin=$MCHS_PKG_BUILDDIR/_prefix/bin
	mkdir -p $bin
	for exe in generate_unicode_utils prepare_unicode_data; do
		$CC_FOR_BUILD $MCHS_PKG_SRCDIR/common/unicode/${exe//_/-}.cpp \
			-o ${bin}/${exe}
	done
	export PATH=$bin:$PATH
}

mchs_step_post_make_install() {
	if [ $_NEED_DUMMY_LIBPTHREAD_A ]; then
		rm -f $_LIBPTHREAD_A
	fi
}

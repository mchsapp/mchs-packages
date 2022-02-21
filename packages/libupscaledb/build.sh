MCHS_PKG_HOMEPAGE=https://upscaledb.com/
MCHS_PKG_DESCRIPTION="A database engine written in C/C++"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=cb124e1f91601872a7b3bd4da10e5fa97a8da86b
_COMMIT_DATE=2021.08.20
MCHS_PKG_VERSION=2.2.1p${_COMMIT_DATE//./}
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/cruppstahl/upscaledb.git
MCHS_PKG_GIT_BRANCH=master
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_DEPENDS="boost, libc++, libsnappy, openssl, zlib"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-simd
--disable-java
--disable-remote
--with-boost=$MCHS_PREFIX
--without-tcmalloc
--without-berkeleydb
"

mchs_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$_COMMIT_DATE" ]; then
		echo -n "ERROR: The specified commit date \"$_COMMIT_DATE\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi
}

mchs_step_pre_configure() {
	sh bootstrap.sh

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

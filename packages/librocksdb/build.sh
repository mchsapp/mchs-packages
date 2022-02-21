MCHS_PKG_HOMEPAGE=https://rocksdb.org/
MCHS_PKG_DESCRIPTION="A persistent key-value store for flash and RAM storage"
MCHS_PKG_LICENSE="GPL-2.0, Apache-2.0, BSD 3-Clause"
MCHS_PKG_LICENSE_FILE="COPYING, LICENSE.Apache, LICENSE.leveldb"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=6.27.3
MCHS_PKG_SRCURL=https://github.com/facebook/rocksdb/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ee29901749b9132692b26f0a6c1d693f47d1a9ed8e3771e60556afe80282bf58
MCHS_PKG_DEPENDS="gflags, libc++"
MCHS_PKG_BUILD_DEPENDS="gflags-static"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DFAIL_ON_WARNINGS=OFF
-DPORTABLE=ON
"
mchs_step_pre_configure() {
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

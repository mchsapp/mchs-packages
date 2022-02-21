MCHS_PKG_HOMEPAGE=https://ravencoin.org/
MCHS_PKG_DESCRIPTION="A peer-to-peer blockchain, handling the efficient creation and transfer of assets from one party to another"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.3.2.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/RavenProject/Ravencoin/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=02e6c12220ba0f9378a3af790a57a0a6e11d7b091adfd91f555aab07341d62e3
MCHS_PKG_DEPENDS="boost, libevent, openssl"
MCHS_PKG_BUILD_DEPENDS="libdb"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-tests
--disable-wallet
--with-boost=$MCHS_PREFIX/lib
--with-boost-libdir=$MCHS_PREFIX/lib
"

mchs_step_pre_configure() {
	autoreconf -fi

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

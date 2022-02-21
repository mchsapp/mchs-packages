MCHS_PKG_HOMEPAGE=https://github.com/Netflix/dynomite
MCHS_PKG_DESCRIPTION="A thin, distributed dynamo layer for different storage engines and protocols"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.6.22
MCHS_PKG_SRCURL=https://github.com/Netflix/dynomite/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=9c3c60d95b39939f3ce596776febe8aa00ae8614ba85aa767e74d41e302e704a
MCHS_PKG_DEPENDS="libyaml, openssl"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_epoll_works=yes
ac_cv_evports_works=no
ac_cv_header_execinfo_h=no
ac_cv_kqueue_works=no
"

mchs_step_pre_configure() {
	autoreconf -fi

	LDFLAGS+=" -Wl,-z,muldefs"

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

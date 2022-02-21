MCHS_PKG_HOMEPAGE=http://log4c.sourceforge.net/
MCHS_PKG_DESCRIPTION="A C library for flexible logging to files, syslog and other destinations"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.2.4
MCHS_PKG_SRCURL=http://prdownloads.sourceforge.net/log4c/log4c-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=5991020192f52cc40fa852fbf6bbf5bd5db5d5d00aa9905c67f6f0eadeed48ea
MCHS_PKG_DEPENDS="libexpat"

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

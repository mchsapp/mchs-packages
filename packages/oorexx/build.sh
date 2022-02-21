MCHS_PKG_HOMEPAGE=https://www.oorexx.org/
MCHS_PKG_DESCRIPTION="Open Object Rexx"
MCHS_PKG_LICENSE="CPL-1.0"
MCHS_PKG_LICENSE_FILE="CPLv1.0.txt, NOTICE"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.2.0
_SOVERSION=${MCHS_PKG_VERSION%%.*}
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/project/oorexx/oorexx/${MCHS_PKG_VERSION}/ooRexx-${MCHS_PKG_VERSION}-source.tar.gz
MCHS_PKG_SHA256=ac5af11e7d4d239d2ebe06f40092f4aebf87fc40740b46458bff3b4069ce6e0b
MCHS_PKG_DEPENDS="libandroid-wordexp, libc++, libcrypt"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_catopen=no"
MCHS_PKG_HOSTBUILD=true
MCHS_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="CFLAGS=-O0"

mchs_step_post_get_source() {
	sed -i 's:__type:_&:g' api/oorexxapi.h
}

mchs_step_pre_configure() {
	export PATH=$MCHS_PKG_HOSTBUILD_DIR:$PATH

	CFLAGS+=" -fwrapv -fno-strict-aliasing"
	LDFLAGS+=" -landroid-wordexp -lcrypt $($CC -print-libgcc-file-name)"

	local dummylibdir=$MCHS_PKG_BUILDDIR/_dummylib
	mkdir -p $dummylibdir
	echo 'void RexxVariablePool(void){}' | $CC -x c - -shared -nostdlib \
		-Wl,-soname=librexx.so.${_SOVERSION} \
		-o $dummylibdir/librexx.so
	echo 'void RexxFreeMemory(void){}' | $CC -x c - -shared -nostdlib \
		-Wl,-soname=librexxapi.so.${_SOVERSION} \
		-o $dummylibdir/librexxapi.so
	export DLDFLAGS="-L./.libs -L${dummylibdir}"

	_NEED_DUMMY_LIBPTHREAD_A=
	_LIBPTHREAD_A=$MCHS_PREFIX/lib/libpthread.a
	if [ ! -e $_LIBPTHREAD_A ]; then
		_NEED_DUMMY_LIBPTHREAD_A=true
		echo '!<arch>' > $_LIBPTHREAD_A
	fi
}

mchs_step_post_configure() {
	sed -i 's:\./\(rexximage\):\1:' Makefile
}

mchs_step_post_make_install() {
	if [ $_NEED_DUMMY_LIBPTHREAD_A ]; then
		rm -f $_LIBPTHREAD_A
	fi
}

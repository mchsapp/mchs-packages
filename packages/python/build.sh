MCHS_PKG_HOMEPAGE=https://python.org/
MCHS_PKG_DESCRIPTION="Python 3 programming language intended to enable clear programs"
MCHS_PKG_LICENSE="PythonPL"
MCHS_PKG_MAINTAINER="@mchs"
_MAJOR_VERSION=3.10
MCHS_PKG_VERSION=${_MAJOR_VERSION}.2
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://www.python.org/ftp/python/${MCHS_PKG_VERSION}/Python-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=17de3ac7da9f2519aa9d64378c603a73a0e9ad58dffa8812e45160c086de64c7
MCHS_PKG_DEPENDS="gdbm, libandroid-posix-semaphore, libandroid-support, libbz2, libcrypt, libexpat, libffi, liblzma, libsqlite, ncurses, ncurses-ui-libs, openssl, readline, zlib"
MCHS_PKG_RECOMMENDS="clang, make, pkg-config"
MCHS_PKG_SUGGESTS="python-tkinter"
MCHS_PKG_BREAKS="python2 (<= 2.7.15), python-dev"
MCHS_PKG_REPLACES="python-dev"
# Let "python3" will be alias to this package.
MCHS_PKG_PROVIDES="python3"

# Set ac_cv_func_wcsftime=no to avoid errors such as "character U+ca0025 is not in range [U+0000; U+10ffff]"
# when executing e.g. "from time import time, strftime, localtime; print(strftime(str('%Y-%m-%d %H:%M'), localtime()))"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_file__dev_ptmx=yes ac_cv_file__dev_ptc=no ac_cv_func_wcsftime=no"
# Avoid trying to include <sys/timeb.h> which does not exist on android-21:
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_ftime=no"
# Avoid trying to use AT_EACCESS which is not defined:
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_faccessat=no"
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" --build=$MCHS_BUILD_TUPLE --with-system-ffi --with-system-expat --without-ensurepip"
# Hard links does not work on Android 6:
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_linkat=no"
# Do not assume getaddrinfo is buggy when cross compiling:
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_buggy_getaddrinfo=no"
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-loadable-sqlite-extensions"
# Fix https://github.com/mchs/mchs-packages/issues/2236:
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_little_endian_double=yes"
# Force enable posix semaphores.
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_posix_semaphores_enabled=yes"
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_sem_open=yes"
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_sem_timedwait=yes"
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_sem_getvalue=yes"
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_sem_unlink=yes"
# Force enable posix shared memory.
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_shm_open=yes"
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_shm_unlink=yes"

MCHS_PKG_RM_AFTER_INSTALL="
lib/python${_MAJOR_VERSION}/test
lib/python${_MAJOR_VERSION}/*/test
lib/python${_MAJOR_VERSION}/*/tests
lib/python${_MAJOR_VERSION}/site-packages/*/
"

mchs_step_pre_configure() {
	# -O3 gains some additional performance on at least aarch64.
	CFLAGS="${CFLAGS/-Oz/-O3}"

	# Needed when building with clang, as setup.py only probes
	# gcc for include paths when finding headers for determining
	# if extension modules should be built (specifically, the
	# zlib extension module is not built without this):
	CPPFLAGS+=" -I$MCHS_STANDALONE_TOOLCHAIN/sysroot/usr/include"
	LDFLAGS+=" -L$MCHS_STANDALONE_TOOLCHAIN/sysroot/usr/lib"
	if [ $MCHS_ARCH = x86_64 ]; then LDFLAGS+=64; fi

	if [ "$MCHS_ON_DEVICE_BUILD" = "true" ]; then
		# Python's configure script fails with
		#    Fatal: you must define __ANDROID_API__
		# if __ANDROID_API__ is not defined.
		CPPFLAGS+=" -D__ANDROID_API__=$(getprop ro.build.version.sdk)"
	fi
}

mchs_step_post_make_install() {
	(cd $MCHS_PREFIX/bin
	 ln -sf idle${_MAJOR_VERSION} idle
	 ln -sf python${_MAJOR_VERSION} python
	 ln -sf python${_MAJOR_VERSION}-config python-config
	 ln -sf pydoc${_MAJOR_VERSION} pydoc)
	(cd $MCHS_PREFIX/share/man/man1
	 ln -sf python${_MAJOR_VERSION}.1 python.1)
}

mchs_step_post_massage() {
	# Verify that desired modules have been included:
	for module in _bz2 _curses _lzma _sqlite3 _ssl _tkinter zlib; do
		if [ ! -f "${MCHS_PREFIX}/lib/python${_MAJOR_VERSION}/lib-dynload/${module}".*.so ]; then
			mchs_error_exit "Python module library $module not built"
		fi
	done
}

mchs_step_create_debscripts() {
	# Post-installation script for setting up pip.
	cat <<- POSTINST_EOF > ./postinst
	#!$MCHS_PREFIX/bin/sh

	echo "Setting up pip..."

	# Fix historical mistake which removed bin/pip but left site-packages/pip-*.dist-info,
	# which causes ensurepip to avoid installing pip due to already existing pip install:
	if [ ! -f "$MCHS_PREFIX/bin/pip" ]; then
	    rm -Rf ${MCHS_PREFIX}/lib/python${_MAJOR_VERSION}/site-packages/pip-*.dist-info
	fi

	${MCHS_PREFIX}/bin/python3 -m ensurepip --upgrade --default-pip

	exit 0
	POSTINST_EOF

	# Pre-rm script to cleanup runtime-generated files.
	cat <<- PRERM_EOF > ./prerm
	#!$MCHS_PREFIX/bin/sh

	if [ "$MCHS_PACKAGE_FORMAT" != "pacman" ] && [ "\$1" != "remove" ]; then
	    exit 0
	fi

	echo "Uninstalling python modules..."
	pip3 freeze 2>/dev/null | xargs pip3 uninstall -y >/dev/null 2>/dev/null
	rm -f $MCHS_PREFIX/bin/pip $MCHS_PREFIX/bin/pip3* $MCHS_PREFIX/bin/easy_install $MCHS_PREFIX/bin/easy_install-3*

	echo "Deleting remaining files from site-packages..."
	rm -Rf $MCHS_PREFIX/lib/python${_MAJOR_VERSION}/site-packages/*

	exit 0
	PRERM_EOF

	chmod 0755 postinst prerm
}

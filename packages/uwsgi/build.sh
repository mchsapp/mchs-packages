MCHS_PKG_HOMEPAGE=https://projects.unbit.it/uwsgi
MCHS_PKG_DESCRIPTION="uWSGI application server container"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.0.19.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/unbit/uwsgi/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=bf17cdbb9bd8bcb7c1633e34d9d7308cb4cc19eb0ff2d61057f840c1ba1fc41b
MCHS_PKG_DEPENDS="libandroid-glob, libcap, libcrypt, libjansson, libuuid, libxml2, openssl, pcre, python"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
	cp $MCHS_PKG_BUILDER_DIR/sys_sem.c $MCHS_PKG_SRCDIR/core/
	cp $MCHS_PKG_BUILDER_DIR/sys_time.c $MCHS_PKG_SRCDIR/core/
	export UWSGI_PYTHON_NOLIB=true
	export UWSGI_INCLUDES="$MCHS_PREFIX/include"
	export APPEND_CFLAGS="$CPPFLAGS -I$MCHS_PREFIX/include/python3.10 -DOBSOLETE_LINUX_KERNEL"
	LDFLAGS+=" -lpython3.10 -landroid-glob"
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin "$MCHS_PKG_BUILDDIR/uwsgi"
}


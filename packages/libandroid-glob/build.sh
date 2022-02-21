MCHS_PKG_HOMEPAGE=https://man7.org/linux/man-pages/man3/glob.3.html
MCHS_PKG_DESCRIPTION="Shared library for the glob(3) system function"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.6
MCHS_PKG_REVISION=2
MCHS_PKG_SKIP_SRC_EXTRACT=true
MCHS_PKG_BREAKS="libandroid-glob-dev"
MCHS_PKG_REPLACES="libandroid-glob-dev"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	$CC $CFLAGS $CPPFLAGS -I$MCHS_PKG_BUILDER_DIR -c $MCHS_PKG_BUILDER_DIR/glob.c
	$CC $LDFLAGS -shared glob.o -o libandroid-glob.so
	$AR rcu libandroid-glob.a glob.o
	cp -f $MCHS_PKG_BUILDER_DIR/LICENSE $MCHS_PKG_SRCDIR/
}

mchs_step_make_install() {
	install -Dm600 $MCHS_PKG_BUILDER_DIR/glob.h $MCHS_PREFIX/include/glob.h
	install -Dm600 libandroid-glob.a $MCHS_PREFIX/lib/libandroid-glob.a
	install -Dm600 libandroid-glob.so $MCHS_PREFIX/lib/libandroid-glob.so
}

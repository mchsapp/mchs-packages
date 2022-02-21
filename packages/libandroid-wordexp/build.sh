MCHS_PKG_HOMEPAGE=https://man7.org/linux/man-pages/man3/wordexp.3.html
MCHS_PKG_DESCRIPTION="Shared library for the wordexp(3) system function"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.1
MCHS_PKG_SKIP_SRC_EXTRACT=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	$CC $CFLAGS $CPPFLAGS -I$MCHS_PKG_BUILDER_DIR -c $MCHS_PKG_BUILDER_DIR/wordexp.c
	$CC $LDFLAGS -shared wordexp.o -o libandroid-wordexp.so
	$AR rcu libandroid-wordexp.a wordexp.o
}

mchs_step_make_install() {
	install -Dm600 $MCHS_PKG_BUILDER_DIR/wordexp.h $MCHS_PREFIX/include/wordexp.h
	install -Dm600 libandroid-wordexp.a $MCHS_PREFIX/lib/libandroid-wordexp.a
	install -Dm600 libandroid-wordexp.so $MCHS_PREFIX/lib/libandroid-wordexp.so
}

MCHS_PKG_HOMEPAGE=https://man7.org/linux/man-pages/man3/posix_spawn.3.html
MCHS_PKG_DESCRIPTION="Shared library for the posix_spawn system function"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.3
MCHS_PKG_SKIP_SRC_EXTRACT=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	$CXX $CFLAGS $CPPFLAGS -I$MCHS_PKG_BUILDER_DIR -c $MCHS_PKG_BUILDER_DIR/posix_spawn.cpp
	$CXX $LDFLAGS -shared posix_spawn.o -o libandroid-spawn.so
	$AR rcu libandroid-spawn.a posix_spawn.o
	cp -f $MCHS_PKG_BUILDER_DIR/LICENSE $MCHS_PKG_SRCDIR/
}

mchs_step_make_install() {
	install -Dm600 $MCHS_PKG_BUILDER_DIR/posix_spawn.h $MCHS_PREFIX/include/spawn.h
	install -Dm600 libandroid-spawn.a $MCHS_PREFIX/lib/libandroid-spawn.a
	install -Dm600 libandroid-spawn.so $MCHS_PREFIX/lib/libandroid-spawn.so
}

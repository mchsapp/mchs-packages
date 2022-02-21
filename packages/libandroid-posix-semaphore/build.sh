MCHS_PKG_HOMEPAGE=https://man7.org/linux/man-pages/man7/sem_overview.7.html
MCHS_PKG_DESCRIPTION="Shared library for the posix semaphore system function"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.1
MCHS_PKG_REVISION=1
MCHS_PKG_SKIP_SRC_EXTRACT=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	$CC $CFLAGS $CPPFLAGS -DPREFIX="\"$MCHS_PREFIX\"" \
		-c $MCHS_PKG_BUILDER_DIR/semaphore.c
	$CC $LDFLAGS -shared semaphore.o -o libandroid-posix-semaphore.so
	$AR rcu libandroid-posix-semaphore.a semaphore.o
	cp -f $MCHS_PKG_BUILDER_DIR/LICENSE $MCHS_PKG_SRCDIR/
}

mchs_step_make_install() {
	install -Dm600 libandroid-posix-semaphore.a $MCHS_PREFIX/lib/libandroid-posix-semaphore.a
	install -Dm600 libandroid-posix-semaphore.so $MCHS_PREFIX/lib/libandroid-posix-semaphore.so
}

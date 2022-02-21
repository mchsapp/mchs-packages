MCHS_PKG_HOMEPAGE=https://android.googlesource.com/platform/ndk/
MCHS_PKG_DESCRIPTION="Thread debugging library"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=22 # removed in NDK r23
MCHS_PKG_SRCURL=https://android.googlesource.com/platform/ndk/+archive/refs/tags/ndk-r${MCHS_PKG_VERSION}/sources/android/libthread_db.tar.gz
MCHS_PKG_SHA256=SKIP_CHECKSUM
MCHS_PKG_BUILD_IN_SRC=true

mchs_extract_src_archive() {
	local file="$MCHS_PKG_CACHEDIR/$(basename "${MCHS_PKG_SRCURL}")"
	mkdir -p "$MCHS_PKG_SRCDIR"
	tar xf "$file" -C "$MCHS_PKG_SRCDIR"
}

mchs_step_make() {
	$CC $CPPFLAGS -I. $CFLAGS libthread_db.c -shared -o libthread_db.so $LDFLAGS
}

mchs_step_make_install() {
	install -Dm600 -t $MCHS_PREFIX/include "$MCHS_PKG_SRCDIR/thread_db.h"
	install -Dm600 -t $MCHS_PREFIX/lib "$MCHS_PKG_BUILDDIR/libthread_db.so"
	ln -sf $MCHS_PREFIX/lib/libthread_db.so $MCHS_PREFIX/lib/libthread_db.so.1
}

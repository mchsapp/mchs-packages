MCHS_PKG_HOMEPAGE=http://mama.indstate.edu/users/ice/tree/
MCHS_PKG_DESCRIPTION="Recursive directory lister producing a depth indented listing of files"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.8.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=http://mama.indstate.edu/users/ice/tree/src/tree-${MCHS_PKG_VERSION}.tgz
MCHS_PKG_SHA256=715d5d4b434321ce74706d0dd067505bb60c5ea83b5f0b3655dae40aa6f9b7c2
MCHS_PKG_DEPENDS="libandroid-support"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	make \
		CC="$CC" \
		CFLAGS="$CFLAGS $CPPFLAGS -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64" \
		LDFLAGS="$LDFLAGS" \
		OBJS="file.o tree.o unix.o html.o xml.o json.o hash.o color.o strverscmp.o"
}

mchs_step_make_install() {
	make install \
		prefix="$MCHS_PREFIX" \
		MANDIR="$MCHS_PREFIX/share/man/man1"
}

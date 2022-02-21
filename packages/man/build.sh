MCHS_PKG_HOMEPAGE=https://mdocml.bsd.lv/
MCHS_PKG_DESCRIPTION="Man page viewer from the mandoc toolset"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.14.5
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=http://mdocml.bsd.lv/snapshots/mandoc-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=8219b42cb56fc07b2aa660574e6211ac38eefdbf21f41b698d3348793ba5d8f7
MCHS_PKG_DEPENDS="less,libandroid-glob,zlib"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_RM_AFTER_INSTALL="share/examples"

mchs_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
	echo "PREFIX=\"$MCHS_PREFIX\"" > configure.local
	echo "CC=\"$CC\"" >> configure.local
	echo "MANDIR=\"$MCHS_PREFIX/share/man\"" >> configure.local
	echo "CFLAGS=\"$CFLAGS -std=c99 -DNULL=0 $CPPFLAGS\"" >> configure.local
	echo "LDFLAGS=\"$LDFLAGS\"" >> configure.local
	for HAVING in HAVE_FGETLN HAVE_MMAP HAVE_STRLCAT HAVE_STRLCPY HAVE_SYS_ENDIAN HAVE_ENDIAN HAVE_NTOHL HAVE_NANOSLEEP HAVE_O_DIRECTORY HAVE_ISBLANK; do
		echo "$HAVING=1" >> configure.local
	done
	echo "HAVE_MANPATH=0" >> configure.local
	echo "HAVE_SQLITE3=1" >> configure.local
}

mchs_step_create_debscripts() {
	[ "$MCHS_PACKAGE_FORMAT" != "pacman" ] && echo "interest-noawait $MCHS_PREFIX/share/man" > triggers

	echo "#!$MCHS_PREFIX/bin/sh" >> postinst
	echo "makewhatis -Q" >> postinst
	echo "exit 0" >> postinst
}

MCHS_PKG_HOMEPAGE=http://smalltalk.gnu.org/
MCHS_PKG_DESCRIPTION="A free implementation of the Smalltalk-80 language"
MCHS_PKG_LICENSE="GPL-2.0, LGPL-2.1"
MCHS_PKG_MAINTAINER="Henrik Grimler @Grimler91"
MCHS_PKG_VERSION=3.2.91
MCHS_PKG_REVISION=14
MCHS_PKG_SRCURL=ftp://alpha.gnu.org/gnu/smalltalk/smalltalk-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=13a7480553c182dbb8092bd4f215781b9ec871758d1db7045c2d8587e4d1bef9
MCHS_PKG_DEPENDS="glib, libandroid-support, libffi, libltdl, libsigsegv, zlib"
MCHS_PKG_BREAKS="smalltalk-dev"
MCHS_PKG_REPLACES="smalltalk-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-gtk"
MCHS_PKG_HOSTBUILD=true

mchs_step_host_build() {
	(cd "$MCHS_PKG_SRCDIR"
		autoreconf -i
		sed 's/int yylineno = 1;//g' -i libgst/genpr-scan.l
		sed 's/int yylineno = 1;//g' -i libgst/genvm-scan.l
		sed 's/int yylineno = 1;//g' -i libgst/genbc-scan.l
	)

	# Building bloxtk on archlinux fails with this error: https://bugs.gentoo.org/582936
	"$MCHS_PKG_SRCDIR"/configure --disable-gtk --disable-bloxtk
	make
}

mchs_step_pre_configure() {
	export LD_LIBRARY_PATH="$MCHS_PKG_HOSTBUILD_DIR/libgst/.libs"
	sed -i \
		"s%@MCHS_PKG_HOSTBUILD_DIR@%$MCHS_PKG_HOSTBUILD_DIR%g" \
		"$MCHS_PKG_SRCDIR"/Makefile.in
}

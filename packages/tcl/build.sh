MCHS_PKG_HOMEPAGE=https://www.tcl.tk/
MCHS_PKG_DESCRIPTION="Powerful but easy to learn dynamic programming language"
MCHS_PKG_LICENSE="custom"
MCHS_PKG_LICENSE_FILE="license.terms"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=8.6.11
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/project/tcl/Tcl/${MCHS_PKG_VERSION}/tcl${MCHS_PKG_VERSION}-src.tar.gz
MCHS_PKG_SHA256=8c0486668586672c5693d7d95817cb05a18c5ecca2f40e2836b9578064088258
MCHS_PKG_DEPENDS="zlib"
MCHS_PKG_BREAKS="tcl-dev, tcl-static"
MCHS_PKG_REPLACES="tcl-dev, tcl-static"
MCHS_PKG_NO_STATICSPLIT=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_memcmp_working=yes
ac_cv_func_memcmp=yes
ac_cv_func_strtod=yes
ac_cv_func_strtoul=yes
tcl_cv_strstr_unbroken=ok
tcl_cv_strtod_buggy=ok
tcl_cv_strtod_unbroken=ok
tcl_cv_strtoul_unbroken=ok
--disable-rpath
--enable-man-symlinks
--mandir=$MCHS_PREFIX/share/man
"

mchs_step_pre_configure() {
	rm -rf $MCHS_PKG_SRCDIR/pkgs/sqlite3* # libsqlite-tcl is a separate package
	MCHS_PKG_SRCDIR=$MCHS_PKG_SRCDIR/unix
	CFLAGS+=" -DBIONIC_IOCTL_NO_SIGNEDNESS_OVERLOAD"
}

mchs_step_post_make_install() {
	# expect needs private headers
	make install-private-headers
	local _MAJOR_VERSION=${MCHS_PKG_VERSION:0:3}
	cd $MCHS_PREFIX/bin
	ln -f -s tclsh$_MAJOR_VERSION tclsh

	# Needed to install $MCHS_PKG_LICENSE_FILE.
	MCHS_PKG_SRCDIR=$(dirname "$MCHS_PKG_SRCDIR")

	#avoid conflict with perl
	mv $MCHS_PREFIX/share/man/man3/Thread.3 $MCHS_PREFIX/share/man/man3/Tcl_Thread.3
}

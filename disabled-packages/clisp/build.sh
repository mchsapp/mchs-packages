MCHS_PKG_HOMEPAGE=http://www.clisp.org/
MCHS_PKG_DESCRIPTION="GNU CLISP - an ANSI Common Lisp Implementation"
MCHS_PKG_VERSION=2.49
MCHS_PKG_SRCURL=http://downloads.sourceforge.net/project/clisp/clisp/${MCHS_PKG_VERSION}/clisp-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_DEPENDS="readline, libandroid-support"
MCHS_MAKE_PROCESSES=1

mchs_step_configure() {
	cd $MCHS_PKG_BUILDDIR

	export XCPPFLAGS="$CPPFLAGS"
	export XCFLAGS="$CFLAGS"
	export XLDFLAGS="$LDFLAGS"

	unset CC
	unset CPPFLAGS
	unset CFLAGS
	unset LDFLAGS

	$MCHS_PKG_SRCDIR/configure \
		--host=$MCHS_HOST_PLATFORM \
		--prefix=$MCHS_PREFIX \
		--enable-shared \
		--disable-static \
		--srcdir=$MCHS_PKG_SRCDIR \
		--ignore-absence-of-libsigsegv \
		ac_cv_func_select=yes
}

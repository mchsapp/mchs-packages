MCHS_PKG_HOMEPAGE=https://subversion.apache.org
MCHS_PKG_DESCRIPTION="Centralized version control system characterized by its simplicity"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.14.1
MCHS_PKG_REVISION=10
MCHS_PKG_SRCURL=https://www.apache.org/dist/subversion/subversion-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=2c5da93c255d2e5569fa91d92457fdb65396b0666fad4fd59b22e154d986e1a9
MCHS_PKG_DEPENDS="apr, apr-util, serf, libexpat, libsqlite, liblz4, utf8proc, zlib"
MCHS_PKG_BREAKS="subversion-dev"
MCHS_PKG_REPLACES="subversion-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
svn_cv_pycfmt_apr_int64_t=UNUSED_REMOVE_AFTER_NEXT_UPDATE
--without-sasl
--without-libmagic
"

mchs_step_pre_configure() {
	CFLAGS+=" -std=c11 -I$MCHS_PREFIX/include/perl"
	LDFLAGS+=" -lm -Wl,--as-needed -L$MCHS_PREFIX/include/perl"
}

mchs_step_post_make_install() {
	make -j $MCHS_MAKE_PROCESSES install-swig-pl-lib

	pushd subversion/bindings/swig/perl/native
	# it's probably not needed to pass all flags to both perl and make
	# but it works
	PERL_MM_USE_DEFAULT=1 INSTALLDIRS=site CC="$CC" LD="$CC" \
		OPTIMIZE="$CFLAGS" CFLAGS="$CFLAGS" CCFLAGS="$CFLAGS" \
		LDFLAGS="$LDFLAGS -lperl" LDDLFLAGS="-shared $CFLAGS $LDFLAGS -lperl" \
		INSTALLSITEMAN3DIR="$MCHS_PREFIX/share/man/man3" \
		perl Makefile.PL PREFIX="$MCHS_PREFIX"
	popd

	make -j $MCHS_MAKE_PROCESSES PREFIX="$MCHS_PREFIX" \
		PERL_MM_USE_DEFAULT=1 INSTALLDIRS=site CC="$CC" LD="$CC" \
		OPTIMIZE="$CFLAGS" CFLAGS="$CFLAGS" CCFLAGS="$CFLAGS" \
		LDFLAGS="$LDFLAGS -lperl" LDDLFLAGS="-shared $CFLAGS $LDFLAGS -lperl" \
		INSTALLSITEMAN3DIR="$MCHS_PREFIX/share/man/man3" \
		install-swig-pl

	local perl_version=$(. $MCHS_SCRIPTDIR/packages/perl/build.sh; echo $MCHS_PKG_VERSION)
	local host_perl_version=$(perl -e 'printf "%vd\n", $^V;')
	cd "$MCHS_PREFIX/lib"
	rm "x86_64-linux-gnu/perl/$host_perl_version/perllocal.pod"
	mkdir -p "perl5/site_perl/$perl_version"
	mv "x86_64-linux-gnu/perl/$host_perl_version" \
		"perl5/site_perl/$perl_version/${MCHS_ARCH}-android"
	rmdir x86_64-linux-gnu/{perl/,}
}

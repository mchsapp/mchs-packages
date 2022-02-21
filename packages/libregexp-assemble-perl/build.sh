MCHS_PKG_HOMEPAGE=https://metacpan.org/pod/Regexp::Assemble
MCHS_PKG_DESCRIPTION="Perl module to merge several regular expressions"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.38
MCHS_PKG_SRCURL=https://salsa.debian.org/perl-team/modules/packages/libregexp-assemble-perl/-/archive/upstream/${MCHS_PKG_VERSION}/libregexp-assemble-perl-upstream-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=ca31b4111b825a4aa5262b07412822457910577881c2edb19407baad3997ebb0
MCHS_PKG_DEPENDS="perl"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true


mchs_step_configure() {
	perl Makefile.PL
}

mchs_step_make_install() {
	local perl_version=$(. $MCHS_SCRIPTDIR/packages/perl/build.sh; echo $MCHS_PKG_VERSION)
	mkdir -p $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/share/man/man3/
	cp $MCHS_PKG_SRCDIR/blib/man3/Regexp::Assemble.3pm \
		$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/share/man/man3/

	mkdir -p $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/lib/perl5/site_perl/$perl_version/Regexp/
	cp $MCHS_PKG_SRCDIR/lib/Regexp/Assemble.pm \
		$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/lib/perl5/site_perl/$perl_version/Regexp/
}

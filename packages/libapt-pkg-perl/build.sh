MCHS_PKG_HOMEPAGE=https://packages.debian.org/libapt-pkg-perl
MCHS_PKG_DESCRIPTION="Perl interface to APT's libapt-pkg"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.1.40
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=http://deb.debian.org/debian/pool/main/liba/libapt-pkg-perl/libapt-pkg-perl_${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=524d2ef77f3d6896c50e7674022d85e4a391a6a2b3c65ba5e50ac671fa7ce4a1
MCHS_PKG_DEPENDS="apt, perl"
MCHS_PKG_BUILD_IN_SRC=true


mchs_step_make() {
	local perl_version=$(. $MCHS_SCRIPTDIR/packages/perl/build.sh; echo $MCHS_PKG_VERSION)
	CFLAGS+=" -I$MCHS_PREFIX/lib/perl5/$perl_version/${MCHS_ARCH}-android/CORE \
		-I$MCHS_PREFIX/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
	LDFLAGS+=" -L$MCHS_PREFIX/lib/perl5/$perl_version/${MCHS_ARCH}-android/CORE \
		-L$MCHS_PREFIX/lib -lperl"
	perl Makefile.PL INSTALLDIRS=perl DESTDIR="$MCHS_PKG_MASSAGEDIR" \
		INSTALLMAN3DIR="$MCHS_PREFIX/share/man/man3" \
		LIB=$MCHS_PREFIX/lib/perl5/site_perl/$perl_version/${MCHS_ARCH}-android
	make CC="${CC}++" LD="${CC}++" OTHERLDFLAGS="$LDFLAGS" CCFLAGS="$CFLAGS"
}

mchs_step_post_massage() {
	local perl_version=$(. $MCHS_SCRIPTDIR/packages/perl/build.sh; echo $MCHS_PKG_VERSION)
	mv $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/lib/perl5/site_perl/$perl_version/${MCHS_ARCH}-android/x86_64-linux-gnu-thread-multi/* \
		$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/lib/perl5/site_perl/$perl_version/${MCHS_ARCH}-android/
	rmdir $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/lib/perl5/site_perl/$perl_version/${MCHS_ARCH}-android/x86_64-linux-gnu-thread-multi
}

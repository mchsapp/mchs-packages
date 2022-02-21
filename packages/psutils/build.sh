MCHS_PKG_HOMEPAGE=https://github.com/rrthomas/psutils
MCHS_PKG_DESCRIPTION="A set of postscript utilities"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.08
MCHS_PKG_SRCURL=https://github.com/rrthomas/psutils/releases/download/v$MCHS_PKG_VERSION/psutils-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=0c8b0168cec3c22a16d870ae345e7b9c5d2db84fa146094866c1c19a93ce8a00
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="ghostscript, perl"
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_post_massage() {
	local perl_version=$(. $MCHS_SCRIPTDIR/packages/perl/build.sh; echo $MCHS_PKG_VERSION)

	# Make sure that perl can find PSUtils module.
	mkdir -p "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/lib/perl5/${perl_version}"
	mv -f "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX"/share/psutils/PSUtils.pm \
		"$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/lib/perl5/${perl_version}"/
	rmdir "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX"/share/psutils
}

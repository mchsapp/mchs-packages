MCHS_PKG_HOMEPAGE=https://exiftool.org/
MCHS_PKG_DESCRIPTION="Utility for reading, writing and editing meta information in a wide variety of files."
MCHS_PKG_LICENSE="Artistic-License-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=12.38
MCHS_PKG_SRCURL="http://www.sno.phy.queensu.ca/~phil/exiftool/Image-ExifTool-$MCHS_PKG_VERSION.tar.gz"
MCHS_PKG_SHA256=dcbb9ac3b913636ff95542022fcf036e8e92c0cc2e518f9b06d21b44bb5ecddf
MCHS_PKG_DEPENDS="perl"

mchs_step_make_install() {
	local current_perl_version=$(. $MCHS_SCRIPTDIR/packages/perl/build.sh; echo $MCHS_PKG_VERSION)

	install -Dm700 "$MCHS_PKG_SRCDIR"/exiftool "$MCHS_PREFIX"/bin/exiftool
	find "$MCHS_PKG_SRCDIR"/lib -name "*.pod" -delete
	mkdir -p "$MCHS_PREFIX/lib/perl5/site_perl/$current_perl_version"
	rm -rf "$MCHS_PREFIX/lib/perl5/site_perl/${current_perl_version}"/{Image,File}
	cp -a "$MCHS_PKG_SRCDIR"/lib/{Image,File} "$MCHS_PREFIX/lib/perl5/site_perl/${current_perl_version}/"
}

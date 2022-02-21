MCHS_PKG_HOMEPAGE=https://irssi.org/
MCHS_PKG_DESCRIPTION="Terminal based IRC client"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.2.3
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/irssi/irssi/releases/download/$MCHS_PKG_VERSION/irssi-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=a647bfefed14d2221fa77b6edac594934dc672c4a560417b1abcbbc6b88d769f
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="glib, libandroid-glob, libiconv, libotr, ncurses, openssl, perl, utf8proc"
MCHS_PKG_BREAKS="irssi-dev"
MCHS_PKG_REPLACES="irssi-dev"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_path_perlpath=$MCHS_PREFIX/bin/perl
--enable-true-color
--with-socks
--with-otr=static
--with-perl=static
"

mchs_step_pre_configure() {
	local perl_version=$(. $MCHS_SCRIPTDIR/packages/perl/build.sh; echo $MCHS_PKG_VERSION)

	# Irssi has no support for cross-compiling perl module,
	# so we add it ourselves.
	sed -e "s|@MCHS_PREFIX@|$MCHS_PREFIX|g" \
		-e "s|@MCHS_PERL_VERSION@|$perl_version|g" \
		-e "s|@MCHS_PERL_TARGET@|${MCHS_ARCH}-android|g" \
		$MCHS_PKG_BUILDER_DIR/perl_config_support.patch.txt | \
		patch -p1
	autoconf
	MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" --with-perl-lib=$MCHS_PREFIX/lib/perl5/site_perl/$perl_version/${MCHS_ARCH}-android"

	LDFLAGS+=" -landroid-glob"

	# Make build log less noisy.
	CFLAGS+=" -Wno-deprecated-declarations"

	# Make sure that perl stuff is reinstalled.
	rm -rf $MCHS_PREFIX/lib/perl5/site_perl/$perl_version/${MCHS_ARCH}-android/x86_64-linux-gnu-thread-multi
}

mchs_step_post_massage() {
	local perl_version=$(. $MCHS_SCRIPTDIR/packages/perl/build.sh; echo $MCHS_PKG_VERSION)
	mv $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/lib/perl5/site_perl/$perl_version/${MCHS_ARCH}-android/x86_64-linux-gnu-thread-multi/* \
		$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/lib/perl5/site_perl/$perl_version/${MCHS_ARCH}-android/
	rm -rf $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/lib/perl5/site_perl/$perl_version/${MCHS_ARCH}-android/x86_64-linux-gnu-thread-multi
}

MCHS_PKG_HOMEPAGE=https://www.clamav.net/
MCHS_PKG_DESCRIPTION="Anti-virus toolkit for Unix"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.103.3
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://www.clamav.net/downloads/production/clamav-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=9f6e3d18449f3d1a3992771d696685249dfa12736fe2b2929858f2c7d8276ae9
MCHS_PKG_DEPENDS="json-c, libandroid-support, libbz2, libc++, libcurl, libltdl, liblzma, libxml2, openssl, pcre2, zlib"
MCHS_PKG_BREAKS="clamav-dev"
MCHS_PKG_REPLACES="clamav-dev"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--sysconfdir=$MCHS_PREFIX/etc/clamav
--with-libcurl=$MCHS_PREFIX
--with-pcre=$MCHS_PREFIX
--with-libjson=$MCHS_PREFIX
--with-openssl=$MCHS_PREFIX
--with-xml=$MCHS_PREFIX
--with-zlib=$MCHS_PREFIX
--disable-clamonacc
--disable-llvm
--disable-dns"

MCHS_PKG_RM_AFTER_INSTALL="
share/man/man5/clamav-milter.conf.5
share/man/man8/clamav-milter.8"

MCHS_PKG_CONFFILES="
etc/clamav/clamd.conf
etc/clamav/freshclam.conf"

mchs_step_pre_configure() {
       export OBJC=$CC
}

mchs_step_post_make_install() {
	for conf in clamd.conf freshclam.conf; do
		sed "s|@MCHS_PREFIX@|$MCHS_PREFIX|" \
			"$MCHS_PKG_BUILDER_DIR"/$conf.in \
			> "$MCHS_PREFIX"/etc/clamav/$conf
	done
	unset conf
}

mchs_step_post_massage() {
	mkdir -p "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX"/var/lib/clamav
	mkdir -p "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX"/var/log/clamav
}

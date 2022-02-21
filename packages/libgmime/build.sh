MCHS_PKG_HOMEPAGE=http://spruce.sourceforge.net/gmime/
MCHS_PKG_DESCRIPTION="MIME message parser and creator"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.2.7
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://download.gnome.org/sources/gmime/${MCHS_PKG_VERSION:0:3}/gmime-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=2aea96647a468ba2160a64e17c6dc6afe674ed9ac86070624a3f584c10737d44
MCHS_PKG_DEPENDS="glib, libffi, libiconv, libidn2, zlib"
MCHS_PKG_BREAKS="libgmime-dev"
MCHS_PKG_REPLACES="libgmime-dev"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_have_iconv_detect_h=yes
--with-libiconv=gnu
--disable-glibtest
--disable-crypto
"

mchs_step_pre_configure() {
	cp "$MCHS_PKG_BUILDER_DIR"/iconv-detect.h ./
}

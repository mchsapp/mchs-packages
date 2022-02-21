MCHS_PKG_HOMEPAGE=http://webdav.org/cadaver/
MCHS_PKG_DESCRIPTION="A command-line WebDAV client for Unix"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.23.3
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=http://webdav.org/cadaver/cadaver-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=fd4ce68a3230ba459a92bcb747fc6afa91e46d803c1d5ffe964b661793c13fca
MCHS_PKG_DEPENDS="libneon"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_prog_XML2_CONFIG=$MCHS_PREFIX/bin/xml2-config
--with-neon=$MCHS_PREFIX
--disable-nls
"

mchs_step_pre_configure() {
	CPPFLAGS+=" -DHAVE_LOCALE_H"
}

MCHS_PKG_HOMEPAGE=https://pagure.io/newt
MCHS_PKG_DESCRIPTION="A programming library for color text mode, widget based user interfaces"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.52.21
MCHS_PKG_SRCURL=https://releases.pagure.org/newt/newt-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=265eb46b55d7eaeb887fca7a1d51fe115658882dfe148164b6c49fccac5abb31
MCHS_PKG_DEPENDS="libandroid-support, libpopt, slang"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-nls
--without-python
--without-tcl
"

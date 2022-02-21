MCHS_PKG_HOMEPAGE=https://erthink.github.io/libmdbx/
MCHS_PKG_DESCRIPTION="An extremely fast, compact, powerful, embedded, transactional key-value database"
MCHS_PKG_LICENSE="OpenLDAP"
MCHS_PKG_LICENSE_FILE="COPYRIGHT, LICENSE"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.11.4
MCHS_PKG_SRCURL=https://github.com/erthink/libmdbx.git
MCHS_PKG_DEPENDS="libc++"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
"

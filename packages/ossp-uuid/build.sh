MCHS_PKG_HOMEPAGE=http://www.ossp.org/pkg/lib/uuid/
MCHS_PKG_DESCRIPTION="ISO-C:1999 uuid generator supporting DCE 1.1, ISO/IEC 11578:1996 and RFC 4122."
MCHS_PKG_LICENSE="ISC"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.6.2
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=http://www.mirrorservice.org/sites/ftp.ossp.org/pkg/lib/uuid/uuid-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=11a615225baa5f8bb686824423f50e4427acd3f70d394765bdff32801f0fd5b0
MCHS_PKG_BREAKS="ossp-uuid-dev"
MCHS_PKG_REPLACES="ossp-uuid-dev"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--includedir=$MCHS_PREFIX/include/ossp-uuid"

mchs_step_pre_configure() {
	export ac_cv_va_copy=C99
}

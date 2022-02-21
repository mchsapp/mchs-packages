MCHS_PKG_HOMEPAGE=https://apr.apache.org/
MCHS_PKG_DESCRIPTION="Apache Portable Runtime Utility Library"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.6.1
MCHS_PKG_REVISION=5
MCHS_PKG_SRCURL=https://downloads.apache.org/apr/apr-util-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=b65e40713da57d004123b6319828be7f1273fbc6490e145874ee1177e112c459
MCHS_PKG_DEPENDS="apr, libcrypt, libexpat, libiconv, libuuid"
MCHS_PKG_BREAKS="apr-util-dev"
MCHS_PKG_REPLACES="apr-util-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_pq_PQsendQueryPrepared=no
--with-apr=$MCHS_PREFIX
--without-sqlite3
"
MCHS_PKG_RM_AFTER_INSTALL="lib/aprutil.exp"

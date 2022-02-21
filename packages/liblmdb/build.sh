MCHS_PKG_HOMEPAGE=https://symas.com/lmdb/
MCHS_PKG_DESCRIPTION="LMDB implements a simplified variant of the BerkeleyDB (BDB) API."
MCHS_PKG_LICENSE="OpenLDAP"
MCHS_PKG_LICENSE_FILE="libraries/liblmdb/LICENSE"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.9.24
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/LMDB/lmdb/archive/LMDB_${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=44602436c52c29d4f301f55f6fd8115f945469b868348e3cddaf91ab2473ea26
MCHS_PKG_EXTRA_MAKE_ARGS="-C libraries/liblmdb"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	CPPFLAGS+=" -DMDB_USE_ROBUST=0"
}

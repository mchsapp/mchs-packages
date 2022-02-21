MCHS_PKG_HOMEPAGE=https://ssdb.io/
MCHS_PKG_DESCRIPTION="A Redis compatible NoSQL database stored on disk"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.9.9
MCHS_PKG_SRCURL=https://github.com/ideawu/ssdb/archive/refs/tags/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=a32009950114984d6e468e10d964b0ef1e846077b69d7c7615715fdfa01aaf6e
MCHS_PKG_DEPENDS="leveldb, libc++"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_MAKE_ARGS="PREFIX=$MCHS_PREFIX/opt/ssdb"

mchs_step_pre_configure() {
	export TARGET_OS=OS_ANDROID_CROSSCOMPILE
}

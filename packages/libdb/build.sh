MCHS_PKG_HOMEPAGE=https://www.oracle.com/database/berkeley-db
MCHS_PKG_DESCRIPTION="The Berkeley DB embedded database system (library)"
MCHS_PKG_LICENSE="BSD 3-Clause"
# We override MCHS_PKG_SRCDIR mchs_step_pre_configure so need to do
# this hack to be able to find the license file.
MCHS_PKG_LICENSE_FILE="../LICENSE"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=18.1.40
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://fossies.org/linux/misc/db-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=0cecb2ef0c67b166de93732769abdeba0555086d51de1090df325e18ee8da9c8
MCHS_PKG_BREAKS="libdb-dev"
MCHS_PKG_REPLACES="libdb-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--enable-hash
--enable-smallbuild
--enable-compat185
db_cv_atomic=gcc-builtin
--enable-cxx
"

mchs_step_pre_configure() {
	MCHS_PKG_SRCDIR=$MCHS_PKG_SRCDIR/dist
}

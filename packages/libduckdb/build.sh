MCHS_PKG_HOMEPAGE=https://duckdb.org/
MCHS_PKG_DESCRIPTION="An in-process SQL OLAP database management system"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.3.2
# we clone to retain the .git directory, to ensure the version in the built executable is correctly populated
MCHS_PKG_SRCURL=https://github.com/duckdb/duckdb.git
MCHS_PKG_DEPENDS="libc++"

mchs_step_pre_configure() {
	LDFLAGS+=" -llog"
}

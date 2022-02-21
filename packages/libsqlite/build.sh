MCHS_PKG_HOMEPAGE=https://www.sqlite.org
MCHS_PKG_DESCRIPTION="Library implementing a self-contained and transactional SQL database engine"
MCHS_PKG_LICENSE="Public Domain"
MCHS_PKG_MAINTAINER="@mchs"
# Note: Updating this version requires bumping libsqlite-tcl package as well.
_SQLITE_MAJOR=3
_SQLITE_MINOR=37
_SQLITE_PATCH=0
MCHS_PKG_VERSION=${_SQLITE_MAJOR}.${_SQLITE_MINOR}.${_SQLITE_PATCH}
MCHS_PKG_SRCURL=https://www.sqlite.org/2021/sqlite-autoconf-${_SQLITE_MAJOR}${_SQLITE_MINOR}0${_SQLITE_PATCH}00.tar.gz
MCHS_PKG_SHA256=731a4651d4d4b36fc7d21db586b2de4dd00af31fd54fb5a9a4b7f492057479f7
MCHS_PKG_DEPENDS="zlib"
MCHS_PKG_BREAKS="libsqlite-dev"
MCHS_PKG_REPLACES="libsqlite-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--enable-readline
--enable-fts3
"

mchs_step_pre_configure() {
	CPPFLAGS+=" -Werror -DSQLITE_ENABLE_DBSTAT_VTAB=1 -DSQLITE_ENABLE_COLUMN_METADATA=1 -DSQLITE_ENABLE_UPDATE_DELETE_LIMIT=1"
	LDFLAGS+=" -lm"
}

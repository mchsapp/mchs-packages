MCHS_PKG_HOMEPAGE=https://mariadb.com/docs/clients/mariadb-connectors/connector-cpp/
MCHS_PKG_DESCRIPTION="Enables C++ applications to establish client connections to MariaDB Enterprise over TLS"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.1.0
MCHS_PKG_SRCURL=https://github.com/mariadb-corporation/mariadb-connector-cpp.git
MCHS_PKG_GIT_BRANCH=$MCHS_PKG_VERSION
MCHS_PKG_DEPENDS="libc++, openssl, zlib"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DINSTALL_LIB_SUFFIX=lib
-DINSTALL_LIBDIR=lib/mariadbcpp
-DINSTALL_PLUGINDIR=lib/mariadbcpp/plugin
-DWITH_EXTERNAL_ZLIB=ON
"

mchs_step_post_get_source() {
	git submodule update --init --recursive
}

mchs_step_pre_configure() {
	LDFLAGS="-Wl,-rpath=$MCHS_PREFIX/lib/mariadbcpp $LDFLAGS"
}

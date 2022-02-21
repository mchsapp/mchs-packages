MCHS_PKG_HOMEPAGE=http://seafile.com
MCHS_PKG_DESCRIPTION="Seafile is a file syncing and sharing software with file encryption and group sharing"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=8.0.3
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/haiwen/seafile/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=a83d5d301cf54819ab96ea0ab53824980efdf6727460b969ce3176b4c5109f6b
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libcurl, libevent, libsearpc, libsqlite, libuuid, openssl, python"
MCHS_PKG_BREAKS="seafile-client-dev, ccnet"
MCHS_PKG_REPLACES="seafile-client-dev, ccnet"
MCHS_PKG_BUILD_IN_SRC=true


mchs_step_pre_configure() {
	./autogen.sh
	export CPPFLAGS="-I$MCHS_PKG_SRCDIR/lib $CPPFLAGS"
	export PYTHON="python3.10"
}

mchs_step_post_configure() {
	#the package has trouble to prepare some headers
	cd $MCHS_PKG_SRCDIR/lib
	python $MCHS_PREFIX/bin/searpc-codegen.py $MCHS_PKG_SRCDIR/lib/rpc_table.py
}

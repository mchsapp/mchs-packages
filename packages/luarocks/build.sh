MCHS_PKG_HOMEPAGE=https://luarocks.org/
MCHS_PKG_DESCRIPTION="Deployment and management system for Lua modules"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.8.0
MCHS_PKG_SRCURL=https://luarocks.org/releases/luarocks-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=56ab9b90f5acbc42eb7a94cf482e6c058a63e8a1effdf572b8b2a6323a06d923
MCHS_PKG_DEPENDS="curl, lua53"
MCHS_PKG_BUILD_DEPENDS="liblua53"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_configure() {
	if $MCHS_ON_DEVICE_BUILD; then
		MCHS_PKG_EXTRA_MAKE_ARGS="LUA=$MCHS_PREFIX/bin/lua5.3"
	else
		MCHS_PKG_EXTRA_MAKE_ARGS="LUA=/usr/bin/lua5.3"
	fi

	./configure --prefix=$MCHS_PREFIX \
		--with-lua=$MCHS_PREFIX \
		--with-lua-include=$MCHS_PREFIX/include/lua5.3 \
		--lua-version=5.3

	# Create temporary symlink to workaround luarock bootstrap
	# script trying to run cross-compiled lua
	mv $MCHS_PREFIX/bin/lua5.3{,.bak}
	ln -sf /usr/bin/lua5.3 $MCHS_PREFIX/bin/lua5.3
}

mchs_step_post_make_install() {
	# Restore lua
	unlink $MCHS_PREFIX/bin/lua5.3
	mv $MCHS_PREFIX/bin/lua5.3{.bak,}
}

mchs_step_post_massage() {
	sed -i "1 s|$|lua|" bin/luarocks
	sed -i "1 s|$|lua|" bin/luarocks-admin

	# Remove lua, due to us moving it back and fourth the package
	# thinks it is a newly compiled program
	rm bin/lua5.3
}

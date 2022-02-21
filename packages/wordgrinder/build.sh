MCHS_PKG_HOMEPAGE=http://cowlark.com/wordgrinder/
MCHS_PKG_DESCRIPTION="A Unicode-aware character cell word processor"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_LICENSE_FILE="licenses/COPYING.Lua, licenses/COPYING.LuaBitOp, licenses/COPYING.LuaFileSystem, licenses/COPYING.Minizip, licenses/COPYING.Scowl, licenses/COPYING.uthash, licenses/COPYING.wcwidth, licenses/COPYING.WordGrinder, licenses/COPYING.xpattern"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.8
MCHS_PKG_SRCURL=https://github.com/davidgiven/wordgrinder/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=856cbed2b4ccd5127f61c4997a30e642d414247970f69932f25b4b5a81b18d3f
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="liblua53, ncurses, zlib"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_ninja

	# Missing and causes install failure.
	touch licenses/COPYING.LuaFileSystem

	make CC=gcc OBJDIR="$PWD/build" "$PWD"/build/lua
	make OBJDIR="$PWD/build" LUA_PACKAGE=lua53
}

mchs_step_make_install() {
	install -Dm700 \
		"$MCHS_PKG_SRCDIR"/bin/wordgrinder-lua53-curses-release \
		"$MCHS_PREFIX"/bin/wordgrinder
	install -Dm600 \
		"$MCHS_PKG_SRCDIR"/bin/wordgrinder.1 \
		"$MCHS_PREFIX"/share/man/man1/
}

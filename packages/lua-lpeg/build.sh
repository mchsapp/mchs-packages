MCHS_PKG_HOMEPAGE=http://www.inf.puc-rio.br/~roberto/lpeg
MCHS_PKG_DESCRIPTION="Pattern-matching library for Lua 5.3"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.0.2
MCHS_PKG_REVISION=6
MCHS_PKG_SRCURL=http://www.inf.puc-rio.br/~roberto/lpeg/lpeg-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=48d66576051b6c78388faad09b70493093264588fcd0f258ddaab1cdd4a15ffe
MCHS_PKG_DEPENDS="liblua53"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	make \
		CC="$CC" \
		CFLAGS="$CFLAGS -fPIC -I$MCHS_PREFIX/include/lua5.3" \
		LDFLAGS="$LDFLAGS -L$MCHS_PREFIX/lib/lua/5.3 -llua5.3" \
		LUADIR="$MCHS_PREFIX"/include/lua/5.3
}

mchs_step_make_install() {
	install -Dm600 lpeg.so "$MCHS_PREFIX"/lib/lua/5.3/lpeg.so
	install -Dm600 re.lua "$MCHS_PREFIX"/share/lua/5.3/re.lua
}

MCHS_PKG_HOMEPAGE=https://www.lua.org
MCHS_PKG_DESCRIPTION="Shared library for the Lua interpreter (v5.2.x)"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.2.4
MCHS_PKG_REVISION=8
MCHS_PKG_SRCURL=https://www.lua.org/ftp/lua-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=b9e2e4aad6789b3b63a056d442f7b39f0ecfca3ae0f1fc0ae4e9614401b69f4b
MCHS_PKG_BREAKS="liblua52-dev"
MCHS_PKG_REPLACES="liblua52-dev"
MCHS_PKG_BUILD_DEPENDS="readline"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
	sed -e "s/%VER%/${MCHS_PKG_VERSION%.*}/g;s/%REL%/${MCHS_PKG_VERSION}/g" \
		-e "s|@MCHS_PREFIX@|$MCHS_PREFIX|" \
		"$MCHS_PKG_BUILDER_DIR"/lua.pc.in > lua.pc
}

mchs_step_make() {
	make -j $MCHS_MAKE_PROCESSES \
		MYCFLAGS="$CFLAGS -fPIC" \
		MYLDFLAGS="$LDFLAGS" \
		CC="$CC" \
		CXX="$CXX" \
		linux
}

mchs_step_make_install() {
	make \
		TO_BIN="lua5.2 luac5.2" \
		TO_LIB="liblua5.2.so liblua5.2.so.5.2 liblua5.2.so.${MCHS_PKG_VERSION} liblua5.2.a" \
		INSTALL_DATA="cp -d" \
		INSTALL_TOP="$MCHS_PREFIX" \
		INSTALL_INC="$MCHS_PREFIX/include/lua5.2" \
		INSTALL_MAN="$MCHS_PREFIX/share/man/man1" \
		install
	install -Dm600 lua.pc "$MCHS_PREFIX"/lib/pkgconfig/lua52.pc

	mv -f "$MCHS_PREFIX"/share/man/man1/lua.1 "$MCHS_PREFIX"/share/man/man1/lua5.2.1
	mv -f "$MCHS_PREFIX"/share/man/man1/luac.1 "$MCHS_PREFIX"/share/man/man1/luac5.2.1
}

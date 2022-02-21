MCHS_PKG_HOMEPAGE=https://www.lua.org
MCHS_PKG_DESCRIPTION="Shared library for the Lua interpreter (v5.1.x)"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.1.5
MCHS_PKG_SRCURL=https://www.lua.org/ftp/lua-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=2640fc56a795f29d28ef15e13c34a47e223960b0240e8cb0a82d9b0738695333
MCHS_PKG_BUILD_DEPENDS="readline"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	CFLAGS+=" -fPIC"
}

mchs_step_configure() {
	sed -e "s/%VER%/${MCHS_PKG_VERSION%.*}/g;s/%REL%/${MCHS_PKG_VERSION}/g" \
		-e "s|@MCHS_PREFIX@|$MCHS_PREFIX|" \
		"$MCHS_PKG_BUILDER_DIR"/lua.pc.in > lua.pc
}

mchs_step_make() {
	make -j $MCHS_MAKE_PROCESSES \
		MYCFLAGS="$CFLAGS" \
		MYLDFLAGS="$LDFLAGS" \
		CC="$CC" \
		CXX="$CXX" \
		linux
}

mchs_step_make_install() {
	make \
		TO_BIN="lua5.1 luac5.1" \
		TO_LIB="liblua5.1.so liblua5.1.so.5.1 liblua5.1.so.${MCHS_PKG_VERSION} liblua5.1.a" \
		INSTALL_DATA="cp -d" \
		INSTALL_TOP="$MCHS_PREFIX" \
		INSTALL_INC="$MCHS_PREFIX/include/lua5.1" \
		INSTALL_MAN="$MCHS_PREFIX/share/man/man1" \
		install
	install -Dm600 lua.pc "$MCHS_PREFIX"/lib/pkgconfig/lua51.pc

	mv -f "$MCHS_PREFIX"/share/man/man1/lua.1 "$MCHS_PREFIX"/share/man/man1/lua5.1.1
	mv -f "$MCHS_PREFIX"/share/man/man1/luac.1 "$MCHS_PREFIX"/share/man/man1/luac5.1.1
}

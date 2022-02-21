MCHS_PKG_HOMEPAGE=https://www.lua.org/
MCHS_PKG_DESCRIPTION="Shared library for the Lua interpreter"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.4.4
MCHS_PKG_SRCURL=https://www.lua.org/ftp/lua-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=164c7849653b80ae67bec4b7473b884bf5cc8d2dca05653475ec2ed27b9ebf61
MCHS_PKG_EXTRA_MAKE_ARGS=linux-readline
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_BREAKS="liblua-dev"
MCHS_PKG_REPLACES="liblua-dev"
MCHS_PKG_BUILD_DEPENDS="readline"

mchs_step_configure() {
	sed -e "s/%VER%/${MCHS_PKG_VERSION%.*}/g;s/%REL%/${MCHS_PKG_VERSION}/g" \
		-e "s|@MCHS_PREFIX@|$MCHS_PREFIX|" \
		"$MCHS_PKG_BUILDER_DIR"/lua.pc.in > lua.pc
}

mchs_step_pre_configure() {
	OLDAR="$AR"
	AR+=" rcu"
	CFLAGS+=" -fPIC -DLUA_COMPAT_5_2 -DLUA_COMPAT_UNPACK"
	export MYLDFLAGS=$LDFLAGS
}

mchs_step_make_install() {
	make \
		TO_BIN="lua5.4 luac5.4" \
		TO_LIB="liblua5.4.so liblua5.4.so.5.4 liblua5.4.so.${MCHS_PKG_VERSION} liblua5.4.a" \
		INSTALL_DATA="cp -d" \
		INSTALL_TOP="$MCHS_PREFIX" \
		INSTALL_INC="$MCHS_PREFIX/include/lua5.4" \
		INSTALL_MAN="$MCHS_PREFIX/share/man/man1" \
		install
	install -Dm600 lua.pc "$MCHS_PREFIX"/lib/pkgconfig/lua54.pc
}

mchs_step_post_make_install() {
	cd "$MCHS_PREFIX"/share/man/man1
	mv -f lua.1 lua5.4.1
	mv -f luac.1 luac5.4.1
	export AR="$OLDAR"
}

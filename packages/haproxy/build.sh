MCHS_PKG_HOMEPAGE=https://www.haproxy.org/
MCHS_PKG_DESCRIPTION="The Reliable, High Performance TCP/HTTP Load Balancer"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.4.8
MCHS_PKG_SRCURL=http://www.haproxy.org/download/${MCHS_PKG_VERSION:0:3}/src/haproxy-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=e3e4c1ad293bc25e8d8790cc5e45133213dda008bfd0228bf3077259b32ebaa5
MCHS_PKG_DEPENDS="liblua53, openssl, pcre, zlib"
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_CONFFILES="etc/haproxy/haproxy.cfg"

mchs_step_make() {
	CC="$CC -Wl,-rpath=$MCHS_PREFIX/lib -Wl,--enable-new-dtags"

	make \
		CPU=generic \
		TARGET=generic \
		USE_GETADDRINFO=1 \
		USE_LUA=1 \
		LUA_INC="$MCHS_PREFIX/include/lua5.3" \
		LUA_LIB="$MCHS_PREFIX/lib"
		LUA_LIB_NAME=lua5.3 \
		USE_OPENSSL=1 \
		USE_PCRE=1 \
		PCRE_INC="$MCHS_PREFIX/include" \
		PCRE_LIB="$MCHS_PREFIX/lib" \
		USE_ZLIB=1 \
		ADDINC="$CPPFLAGS" \
		CFLAGS="$CFLAGS" \
		LDFLAGS="$LDFLAGS"
}

mchs_step_post_make_install() {
	mkdir -p "$MCHS_PREFIX"/etc/haproxy
	sed -e "s|@MCHS_PREFIX@|${MCHS_PREFIX}|g" \
		"$MCHS_PKG_BUILDER_DIR"/haproxy.cfg.in \
		> "$MCHS_PREFIX"/etc/haproxy/haproxy.cfg

	mkdir -p "$MCHS_PREFIX"/share/haproxy/examples/errorfiles
	install -m600 examples/*.cfg "$MCHS_PREFIX"/share/haproxy/examples/
	install -m600 examples/errorfiles/*.http \
		"$MCHS_PREFIX"/share/haproxy/examples/errorfiles/
}

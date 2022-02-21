MCHS_PKG_HOMEPAGE=https://github.com/vysheng/tg
MCHS_PKG_DESCRIPTION="Telegram messenger CLI"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1:1.4.1
MCHS_PKG_REVISION=3
MCHS_PKG_DEPENDS="libconfig, libevent, libjansson, openssl, readline, zlib"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-liblua"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_SKIP_SRC_EXTRACT=true
MCHS_PKG_HOSTBUILD=true

mchs_step_get_source() {
	mkdir -p "$MCHS_PKG_SRCDIR"
	cd "$MCHS_PKG_SRCDIR"
	git clone https://github.com/vysheng/tg
	cd tg
	git checkout 6547c0b21b977b327b3c5e8142963f4bc246187a
	git submodule update --init --recursive
	mv * ../
}

mchs_step_host_build() {
	cp -rf $MCHS_PKG_SRCDIR/* ./
	./configure --disable-liblua
	make bin/generate
	make bin/tl-parser
}

mchs_step_pre_configure() {
	# avoid duplicated symbol errors
	CFLAGS+=" -fcommon"
}

mchs_step_post_configure() {
	cp -a $MCHS_PKG_HOSTBUILD_DIR/bin ./
	touch -d "next hour" bin/generate bin/tl-parser
	sed -i -e 's@-I/usr/local/include@@g' -e 's@-I/usr/include@@g' Makefile
}

mchs_step_make_install() {
	install -Dm700 -t "$MCHS_PREFIX"/bin/ bin/telegram-cli
	install -Dm600 tg-server.pub "$MCHS_PREFIX"/etc/telegram-cli/server.pub
	install -Dm600 -t "$MCHS_PREFIX"/share/man/man8/ debian/telegram-cli.8
}

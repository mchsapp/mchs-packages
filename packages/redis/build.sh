MCHS_PKG_HOMEPAGE=https://redis.io/
MCHS_PKG_DESCRIPTION="In-memory data structure store used as a database, cache and message broker"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=6.2.6
MCHS_PKG_SRCURL=http://download.redis.io/releases/redis-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=5b2b8b7a50111ef395bf1c1d5be11e6e167ac018125055daa8b5c2317ae131ab
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_CONFFILES="etc/redis.conf"

mchs_step_pre_configure() {
	export PREFIX=$MCHS_PREFIX
	export USE_JEMALLOC=no

	if [ $MCHS_ARCH = "i686" ]; then
		sed -i 's/FINAL_LIBS=-lm/FINAL_LIBS=-lm -latomic/' $MCHS_PKG_SRCDIR/src/Makefile
	fi
}

mchs_step_post_make_install() {
	install -Dm600 $MCHS_PKG_SRCDIR/redis.conf $MCHS_PREFIX/etc/redis.conf
}

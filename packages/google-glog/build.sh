MCHS_PKG_HOMEPAGE=https://github.com/google/glog
MCHS_PKG_DESCRIPTION="Logging library for C++"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.5.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/google/glog/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=eede71f28371bf39aa69b45de23b329d37214016e2055269b3b5e7cfd40b59f5
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="gflags, libc++"
MCHS_PKG_BUILD_DEPENDS="gflags-static"
MCHS_PKG_BREAKS="google-glog-dev"
MCHS_PKG_REPLACES="google-glog-dev"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON"

mchs_step_pre_configure() {
	LDFLAGS+=" -llog"
}

mchs_step_post_make_install() {
	install -Dm600 "$MCHS_PKG_SRCDIR"/libglog.pc.in \
		"$MCHS_PREFIX"/lib/pkgconfig/libglog.pc
	sed -i "s|@prefix@|$MCHS_PREFIX|g" "$MCHS_PREFIX"/lib/pkgconfig/libglog.pc
	sed -i "s|@exec_prefix@|$MCHS_PREFIX|g" "$MCHS_PREFIX"/lib/pkgconfig/libglog.pc
	sed -i "s|@libdir@|$MCHS_PREFIX/lib|g" "$MCHS_PREFIX"/lib/pkgconfig/libglog.pc
	sed -i "s|@includedir@|$MCHS_PREFIX/include|g" "$MCHS_PREFIX"/lib/pkgconfig/libglog.pc
	sed -i "s|@VERSION@|$MCHS_PKG_VERSION|g" "$MCHS_PREFIX"/lib/pkgconfig/libglog.pc
}

MCHS_PKG_HOMEPAGE=https://libwebsockets.org
MCHS_PKG_DESCRIPTION="Lightweight C websockets library"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.3.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/warmcat/libwebsockets/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ceef46e3bffb368efe4959202f128fd93d74e10cd2e6c3ac289a33b075645c3b
MCHS_PKG_DEPENDS="openssl, libcap, libuv, zlib"
MCHS_PKG_BREAKS="libwebsockets-dev"
MCHS_PKG_REPLACES="libwebsockets-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DLWS_WITHOUT_TESTAPPS=ON
-DLWS_WITH_STATIC=OFF
-DLWS_WITH_LIBUV=ON
-DLWS_WITHOUT_EXTENSIONS=OFF
-DLWS_BUILD_HASH=no_hash
"
MCHS_PKG_RM_AFTER_INSTALL="lib/pkgconfig/libwebsockets_static.pc"

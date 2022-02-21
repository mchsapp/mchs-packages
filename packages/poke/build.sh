MCHS_PKG_HOMEPAGE=http://www.jemarch.net/poke.html
MCHS_PKG_DESCRIPTION="Interactive, extensible editor for binary data."
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/poke/poke-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ba7863034a1b08004b0ee8f88bda94160707e9a781d5556f555b507583cf0f1b
MCHS_PKG_DEPENDS="readline, gettext, json-c, libgc"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS=" --with-sysroot=$(dirname $MCHS_PREFIX) --disable-threads --disable-hserver"

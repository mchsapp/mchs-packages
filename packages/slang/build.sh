MCHS_PKG_HOMEPAGE=https://www.jedsoft.org/slang/
MCHS_PKG_DESCRIPTION="S-Lang is a powerful interpreted language"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.3.2
MCHS_PKG_SRCURL=https://www.jedsoft.org/releases/slang/slang-$MCHS_PKG_VERSION.tar.bz2
MCHS_PKG_SHA256=fc9e3b0fc4f67c3c1f6d43c90c16a5c42d117b8e28457c5b46831b8b5d3ae31a
MCHS_PKG_DEPENDS="libiconv, libpng, pcre, oniguruma, zlib"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_CONFFILES="etc/slsh.rc"

# Supports only make -j1
MCHS_MAKE_PROCESSES=1

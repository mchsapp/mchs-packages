MCHS_PKG_HOMEPAGE=https://hunspell.github.io
MCHS_PKG_DESCRIPTION="Spell checker"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.7.0
MCHS_PKG_REVISION=6
MCHS_PKG_SRCURL=https://github.com/hunspell/hunspell/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=bb27b86eb910a8285407cf3ca33b62643a02798cf2eef468c0a74f6c3ee6bc8a
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libc++, libiconv, ncurses, readline, hunspell-en-us"
MCHS_PKG_BREAKS="hunspell-dev"
MCHS_PKG_REPLACES="hunspell-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-ui --with-readline"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	autoreconf -vfi
}

MCHS_PKG_HOMEPAGE=https://abiword.github.io/enchant/
MCHS_PKG_DESCRIPTION="Wraps a number of different spelling libraries and programs with a consistent interface."
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.3.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/AbiWord/enchant/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=d1917e069a5786cc6b13a1eea565cb531feaa6d100fd07dcefb2a41dadf3f611
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--enable-relocatable" 
MCHS_PKG_DEPENDS="aspell, glib, hunspell"

mchs_step_post_get_source() {
	./bootstrap
}

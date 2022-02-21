MCHS_PKG_HOMEPAGE=https://wiki.linuxquestions.org/wiki/Corkscrew
MCHS_PKG_DESCRIPTION="A tool for tunneling SSH through HTTP proxies"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.0
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/mchs/distfiles/releases/download/2021.01.04/corkscrew-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=0d0fcbb41cba4a81c4ab494459472086f377f9edb78a2e2238ed19b58956b0be
MCHS_PKG_DEPENDS="openssh"

mchs_step_post_make_install() {
	# Corkscrew does not distribute a man page, use one from debian:
	mkdir -p $MCHS_PREFIX/share/man/man1
	cp $MCHS_PKG_BUILDER_DIR/corkscrew.1 $MCHS_PREFIX/share/man/man1
}

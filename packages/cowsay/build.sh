MCHS_PKG_HOMEPAGE=https://en.wikipedia.org/wiki/Cowsay
MCHS_PKG_DESCRIPTION="Program which generates ASCII pictures of a cow with a message"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.04
MCHS_PKG_SRCURL=http://http.debian.net/debian/pool/main/c/cowsay/cowsay_3.03+dfsg1.orig.tar.gz
MCHS_PKG_SHA256=10bae895d9afb2d720d2211db58f396352b00fe1386c369ca3608cbf6497b839
MCHS_PKG_DEPENDS="perl"
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make_install() {
	cd $MCHS_PKG_SRCDIR
	sh install.sh
}

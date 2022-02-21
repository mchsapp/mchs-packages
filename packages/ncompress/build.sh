MCHS_PKG_HOMEPAGE=https://github.com/vapier/ncompress
MCHS_PKG_DESCRIPTION="The classic unix compression utility which can handle the ancient .Z archive"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.0
MCHS_PKG_SRCURL=https://github.com/vapier/ncompress/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=96ec931d06ab827fccad377839bfb91955274568392ddecf809e443443aead46
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make_install() {
	mkdir -p "$MCHS_PREFIX"/share/man/man1/
	install -Dm700 compress "$MCHS_PREFIX"/bin/
	install -Dm600 compress.1 "$MCHS_PREFIX"/share/man/man1/
}

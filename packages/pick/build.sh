MCHS_PKG_HOMEPAGE=https://github.com/calleerlandsson/pick
MCHS_PKG_DESCRIPTION="Utility to choose one option from a set of choices with fuzzy search functionality"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.0.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/calleerlandsson/pick/releases/download/v${MCHS_PKG_VERSION}/pick-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=de768fd566fd4c7f7b630144c8120b779a61a8cd35898f0db42ba8af5131edca
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	export MANDIR=$MCHS_PREFIX/share/man
}

MCHS_PKG_HOMEPAGE=https://github.com/gogakoreli/snake
MCHS_PKG_DESCRIPTION="Eat as much as you want while avoiding walls."
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="Tipz Team @TipzTeam"
MCHS_PKG_VERSION=2017.06.09
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/gogakoreli/snake/archive/4ccdf33feaa0a24578f3ddcf8137e52c93444f15.tar.gz
MCHS_PKG_SHA256=f99212d620ac593272a0489a7d83b44f92a39bcd11c299c728ea08f1eee656a6
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_GROUPS="games"

mchs_step_make_install() {
	install -Dm755 -t $MCHS_PREFIX/bin/ snake
}

mchs_step_install_license() {
	install -Dm644 -t $MCHS_PREFIX/share/doc/snake/ \
		$MCHS_PKG_BUILDER_DIR/LICENSE
}

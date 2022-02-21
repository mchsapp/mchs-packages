MCHS_PKG_HOMEPAGE=https://github.com/jarun/nnn
MCHS_PKG_DESCRIPTION="Free, fast, friendly file browser"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.4
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/jarun/nnn/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=e04a3f0f0c2af1e18cb6f005d18267c7703644274d21bb93f03b30e4fd3d1653
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="file, findutils, readline, wget, libandroid-support, lzip"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_post_make_install() {
	install -Dm600 misc/auto-completion/bash/nnn-completion.bash \
		$MCHS_PREFIX/share/bash-completion/completions/nnn
	install -Dm600 misc/auto-completion/fish/nnn.fish \
		$MCHS_PREFIX/share/fish/vendor_completions.d/nnn.fish
	install -Dm600 misc/auto-completion/zsh/_nnn \
		$MCHS_PREFIX/share/zsh/site-functions/_nnn
}

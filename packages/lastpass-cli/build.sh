MCHS_PKG_HOMEPAGE=https://lastpass.com/
MCHS_PKG_DESCRIPTION="LastPass command line interface tool"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3.3
MCHS_PKG_REVISION=7
MCHS_PKG_SRCURL=https://github.com/lastpass/lastpass-cli/archive/v$MCHS_PKG_VERSION/lastpass-cli-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=f38e1ee7e06e660433a575a23b061c2f66ec666d746e988716b2c88de59aed73
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libcurl, libxml2, openssl, pinentry"
MCHS_PKG_SUGGESTS="mchs-api"

mchs_step_post_make_install() {
	ninja install-doc

	install -Dm600 "$MCHS_PKG_SRCDIR"/contrib/lpass_zsh_completion \
		"$MCHS_PREFIX"/share/zsh/site-functions/_lpass

	install -Dm600 "$MCHS_PKG_SRCDIR"/contrib/completions-lpass.fish \
		"$MCHS_PREFIX"/share/fish/vendor_completions.d/lpass.fish
}

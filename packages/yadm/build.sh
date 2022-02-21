MCHS_PKG_HOMEPAGE=https://github.com/TheLocehiliosan/yadm
MCHS_PKG_DESCRIPTION="Yet Another Dotfiles Manager"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.1.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/TheLocehiliosan/yadm/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=9f848c80deed2725c012d058bd60d1ea13539fd6fbacd5245bf97d442cb89263
MCHS_PKG_DEPENDS="git"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	# Do not try to run 'make' as it causes a build failure.
	return
}

mchs_step_make_install() {
	install -Dm700 "$MCHS_PKG_SRCDIR"/yadm "$MCHS_PREFIX"/bin/
	install -Dm600 "$MCHS_PKG_SRCDIR"/yadm.1 "$MCHS_PREFIX"/share/man/man1/
	install -Dm600 "$MCHS_PKG_SRCDIR"/completion/bash/yadm \
		"$MCHS_PREFIX"/share/bash-completion/completions/yadm
	install -Dm600 "$MCHS_PKG_SRCDIR"/completion/zsh/_yadm \
		"$MCHS_PREFIX"/share/zsh/site-functions/_yadm
	install -Dm600 "$MCHS_PKG_SRCDIR"/completion/fish/yadm.fish \
		"$MCHS_PREFIX"/share/fish/vendor_completions.d/yadm.fish
}

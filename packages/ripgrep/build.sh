MCHS_PKG_HOMEPAGE=https://github.com/BurntSushi/ripgrep
MCHS_PKG_DESCRIPTION="Search tool like grep and The Silver Searcher"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=13.0.0
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/BurntSushi/ripgrep/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=0fb17aaf285b3eee8ddab17b833af1e190d73de317ff9648751ab0660d763ed2
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="pcre2"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--features pcre2"

mchs_step_post_make_install() {
	# Install man page:
	mkdir -p $MCHS_PREFIX/share/man/man1/
	cp $(find . -name rg.1) $MCHS_PREFIX/share/man/man1/

	# Install bash completion script:
	mkdir -p $MCHS_PREFIX/share/bash-completion/completions/
	cp $(find . -name rg.bash) $MCHS_PREFIX/share/bash-completion/completions/rg

	# Install fish completion script:
	mkdir -p $MCHS_PREFIX/share/fish/vendor_completions.d/
	cp $(find . -name rg.fish) $MCHS_PREFIX/share/fish/vendor_completions.d/

	# Install zsh completion script:
	mkdir -p $MCHS_PREFIX/share/zsh/site-functions/
	cp complete/_rg $MCHS_PREFIX/share/zsh/site-functions/
}

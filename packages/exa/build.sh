MCHS_PKG_HOMEPAGE=https://the.exa.website
MCHS_PKG_DESCRIPTION="A modern replacement for ls"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.10.1
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/ogham/exa/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ff0fa0bfc4edef8bdbbb3cabe6fdbd5481a71abbbcc2159f402dea515353ae7c
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="zlib, libgit2"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	mchs_setup_rust

	CFLAGS="$CPPFLAGS"
}

mchs_step_post_make_install() {
	mkdir -p $MCHS_PREFIX/share/man/man1
	mkdir -p $MCHS_PREFIX/share/man/man5
	pandoc --standalone --to man $MCHS_PKG_SRCDIR/man/exa.1.md --output $MCHS_PREFIX/share/man/man1/exa.1
	pandoc --standalone --to man $MCHS_PKG_SRCDIR/man/exa_colors.5.md --output $MCHS_PREFIX/share/man/man5/exa_colors.5

	# For 0.10.1, this is the location of the completion files,
	# but they were moved after the release
	if [ -f 'completions/completions.bash' ]; then
		install -Dm600 completions/completions.bash \
			$MCHS_PREFIX/share/bash-completion/completions/exa
		install -Dm600 completions/completions.fish \
			$MCHS_PREFIX/share/fish/vendor_completions.d/exa.fish
		install -Dm600 completions/completions.zsh \
			$MCHS_PREFIX/share/zsh/site-functions/_exa
	else
		install -Dm600 completions/bash/exa \
			$MCHS_PREFIX/share/bash-completion/completions/exa
		install -Dm600 completions/fish/exa.fish \
			$MCHS_PREFIX/share/fish/vendor_completions.d/exa.fish
		install -Dm600 completions/zsh/_exa \
			$MCHS_PREFIX/share/zsh/site-functions/_exa
	fi
}

MCHS_PKG_HOMEPAGE=https://github.com/svenstaro/miniserve
MCHS_PKG_DESCRIPTION="Tool to serve files via HTTP"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.18.0
MCHS_PKG_SRCURL=https://github.com/svenstaro/miniserve/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=24860f103879fd881a522a7ad8f25f2c9dcd5e01287b0485bcabf3e88c719015
MCHS_PKG_DEPENDS=libbz2
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	rm -f Makefile
}

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$MCHS_PREFIX/bin/sh

	# Generating shell completions.
	mkdir -p $MCHS_PREFIX/share/bash-completion/completions
	mkdir -p $MCHS_PREFIX/share/zsh/site-functions
	mkdir -p $MCHS_PREFIX/share/fish/vendor_completions.d

	miniserve --print-completions bash \
		> "$MCHS_PREFIX"/share/bash-completion/completions/miniserve
	miniserve --print-completions zsh \
		> "$MCHS_PREFIX"/share/zsh/site-functions/_miniserve
	miniserve --print-completions fish \
		> "$MCHS_PREFIX"/share/fish/vendor_completions.d/miniserve.fish

	# Warn user on default behaviour of miniserve.
	echo
	echo "WARNING: miniserve follows symlinks in selected directory by default. Consider aliasing it with '--no-symlinks' for safety."
	echo "See: https://github.com/svenstaro/miniserve/issues/498"
	echo
	EOF
}

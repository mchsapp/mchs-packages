MCHS_PKG_HOMEPAGE=https://github.com/dandavison/delta
MCHS_PKG_DESCRIPTION="A syntax-highlighter for git and diff output"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.12.0
MCHS_PKG_SRCURL=https://github.com/dandavison/delta/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=36ef6b05984e7c3b6e42aa35999c6c9ea1cd8c38c6ea940c03d3c9f25af12d6d
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="git"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	rm -f Makefile release.Makefile
	export CC_x86_64_unknown_linux_gnu=gcc
	export CFLAGS_x86_64_unknown_linux_gnu="-O2"
}

mchs_step_post_make_install() {
	install -Dm700 -t "$MCHS_PREFIX"/bin \
		"$MCHS_PKG_SRCDIR/target/$CARGO_TARGET_NAME"/release/delta
	install -Dm600 "$MCHS_PKG_SRCDIR"/etc/completion/completion.bash \
		"$MCHS_PREFIX"/share/bash-completion/completions/delta
}

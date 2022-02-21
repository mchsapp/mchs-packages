MCHS_PKG_HOMEPAGE=https://tmux.github.io/
MCHS_PKG_DESCRIPTION="Terminal multiplexer"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
# Link against libandroid-support for wcwidth(), see https://github.com/mchs/mchs-packages/issues/224
MCHS_PKG_DEPENDS="ncurses, libevent, libandroid-support, libandroid-glob"
MCHS_PKG_VERSION=3.2a
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL="https://github.com/tmux/tmux/archive/${MCHS_PKG_VERSION}.tar.gz"
MCHS_PKG_SHA256=497bc4ee16f10b53b161bf0253b6f9e20cd0f86c5d0104f149212cb0778ae13a
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-static"
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_CONFFILES="etc/tmux.conf etc/profile.d/tmux.sh"

mchs_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
	./autogen.sh
}

mchs_step_post_make_install() {
	cp "$MCHS_PKG_BUILDER_DIR"/tmux.conf "$MCHS_PREFIX"/etc/tmux.conf

	mkdir -p "$MCHS_PREFIX"/etc/profile.d
	echo "export TMUX_TMPDIR=$MCHS_PREFIX/var/run" > "$MCHS_PREFIX"/etc/profile.d/tmux.sh

	mkdir -p "$MCHS_PREFIX"/share/bash-completion/completions
	mchs_download \
		https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/homebrew_1.0.0/completions/tmux \
		"$MCHS_PREFIX"/share/bash-completion/completions/tmux \
		05e79fc1ecb27637dc9d6a52c315b8f207cf010cdcee9928805525076c9020ae
}

mchs_step_create_debscripts() {
	echo "#!$MCHS_PREFIX/bin/sh" > postinst
	echo "mkdir -p $MCHS_PREFIX/var/run" >> postinst
}

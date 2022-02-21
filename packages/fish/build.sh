MCHS_PKG_HOMEPAGE=https://fishshell.com/
MCHS_PKG_DESCRIPTION="The user-friendly command line shell"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.3.1
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://github.com/fish-shell/fish-shell/releases/download/$MCHS_PKG_VERSION/fish-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=b5b4ee1a5269762cbbe993a4bd6507e675e4100ce9bbe84214a5eeb2b19fae89
MCHS_PKG_AUTO_UPDATE=true
# fish calls 'tput' from ncurses-utils, at least when cancelling (Ctrl+C) a command line.
# man is needed since fish calls apropos during command completion.
MCHS_PKG_DEPENDS="libc++, ncurses, libandroid-support, ncurses-utils, man, bc, pcre2, libandroid-spawn"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_DOCS=OFF
"

mchs_step_pre_configure() {
	CXXFLAGS+=" $CPPFLAGS"
}

mchs_step_post_make_install() {
	cat >> $MCHS_PREFIX/etc/fish/config.fish <<HERE

function __fish_command_not_found_handler --on-event fish_command_not_found
	$MCHS_PREFIX/libexec/mchs/command-not-found \$argv[1]
end
HERE
}

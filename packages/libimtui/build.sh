MCHS_PKG_HOMEPAGE=https://github.com/ggerganov/imtui
MCHS_PKG_DESCRIPTION="An immediate mode text-based user interface library"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_LICENSE_FILE="LICENSE, third-party/imgui/imgui/LICENSE.txt"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.0.5
MCHS_PKG_SRCURL=https://github.com/ggerganov/imtui.git
MCHS_PKG_DEPENDS="libc++, ncurses"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
"

mchs_step_post_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin bin/hnterm
}

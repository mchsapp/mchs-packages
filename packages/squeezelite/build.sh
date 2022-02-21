MCHS_PKG_HOMEPAGE=https://ralph-irving.github.io/squeezelite.html
MCHS_PKG_DESCRIPTION="A small headless Logitech Squeezebox emulator"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.9.9
_COMMIT=370020f2dd572f0ab5464d8ef4e47ebf21b19468
MCHS_PKG_SRCURL=https://github.com/ralph-irving/squeezelite.git
MCHS_PKG_GIT_BRANCH=master
MCHS_PKG_DEPENDS="libmad, mpg123, pulseaudio"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT
}

mchs_step_pre_configure() {
	export OPTS="-DLINKALL -DNO_FAAD -DPULSEAUDIO"
	export LDADD="-lm"
}

mchs_step_make_install() {
	install -Dm700 squeezelite $MCHS_PREFIX/bin/
}

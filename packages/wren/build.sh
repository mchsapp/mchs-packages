MCHS_PKG_HOMEPAGE=https://wren.io/
MCHS_PKG_DESCRIPTION="Small, fast, class-based concurrent scripting language interpreter"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.4.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/wren-lang/wren-cli/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=fafdc5d6615114d40de3956cd3a255e8737dadf8bd758b48bac00db61563cb4c
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libuv"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	local QUIET_BUILD=
	if [ "$MCHS_QUIET_BUILD" = true ]; then
		QUIET_BUILD="-s"
	fi

	cd projects/make
	if [ "$MCHS_ARCH" = i686 ] || [ "$MCHS_ARCH" = arm ]; then
		RELEASE=release_32bit
	else
		RELEASE=release_64bit
	fi
	make -j $MCHS_MAKE_PROCESSES $QUIET_BUILD config=${RELEASE}
}

mchs_step_make_install() {
	install -Dm700 "$MCHS_PKG_SRCDIR"/bin/wren_cli \
		"$MCHS_PREFIX"/bin/wren
}

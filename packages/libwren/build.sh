MCHS_PKG_HOMEPAGE=https://wren.io/
MCHS_PKG_DESCRIPTION="Small, fast, class-based concurrent scripting language libraries"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.4.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/wren-lang/wren/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=23c0ddeb6c67a4ed9285bded49f7c91714922c2e7bb88f42428386bf1cf7b339
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BREAKS="wren-dev, wren (<< 0.3.0)"
MCHS_PKG_REPLACES="wren-dev, wren (<< 0.3.0)"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_NO_STATICSPLIT=true

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
	install -Dm600 "$MCHS_PKG_SRCDIR"/src/include/wren.h \
		"$MCHS_PREFIX"/include/wren.h

	install -Dm600 "$MCHS_PKG_SRCDIR"/lib/libwren.so \
		"$MCHS_PREFIX"/lib/libwren.so

	install -Dm600 "$MCHS_PKG_SRCDIR"/lib/libwren.a \
		"$MCHS_PREFIX"/lib/libwren.a
}

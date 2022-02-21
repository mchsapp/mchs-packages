MCHS_PKG_HOMEPAGE=http://simh.trailing-edge.com/
MCHS_PKG_DESCRIPTION="A collection of simulators for computer hardware and software from the past"
MCHS_PKG_LICENSE="MIT, BSD 2-Clause"
MCHS_PKG_LICENSE_FILE="LICENSE, slirp/COPYRIGHT"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=370bfe006d9f9fb87885c31f943d151013cd529f
MCHS_PKG_VERSION=2022.01.16
MCHS_PKG_SRCURL=https://github.com/simh/simh.git
MCHS_PKG_GIT_BRANCH=master
MCHS_PKG_DEPENDS="libandroid-glob"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_MAKE_ARGS="DONT_USE_ROMS=1 TESTS=0"

mchs_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$MCHS_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$MCHS_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi

	cp $MCHS_PKG_BUILDER_DIR/LICENSE ./
}

mchs_step_pre_configure() {
	CFLAGS+=" -fwrapv"
	LDFLAGS+=" -lm -landroid-glob"
}

mchs_step_make() {
	make -j $MCHS_MAKE_PROCESSES \
		GCC="$CC" CFLAGS_O="$CFLAGS $CPPFLAGS" LDFLAGS="$LDFLAGS" \
		$MCHS_PKG_EXTRA_MAKE_ARGS
}

mchs_step_make_install() {
	for f in BIN/*; do
		if [ -f "$f" ]; then
			local b="$(basename "$f")"
			install -Dm700 -T "$f" $MCHS_PREFIX/bin/simh-"$b"
		fi
	done
	local sharedir=$MCHS_PREFIX/share/simh
	mkdir -p $sharedir
	for f in */*.bin; do
		install -Dm600 -T "$f" $sharedir/"$f"
	done
}

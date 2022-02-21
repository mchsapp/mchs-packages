mchs_step_make() {
	[ "$MCHS_PKG_METAPACKAGE" = "true" ] && return

	local QUIET_BUILD=
	if [ "$MCHS_QUIET_BUILD" = true ]; then
		QUIET_BUILD="-s"
	fi

	if test -f build.ninja; then
		ninja -w dupbuild=warn -j $MCHS_MAKE_PROCESSES
	elif ls ./*akefile &> /dev/null || [ ! -z "$MCHS_PKG_EXTRA_MAKE_ARGS" ]; then
		if [ -z "$MCHS_PKG_EXTRA_MAKE_ARGS" ]; then
			make -j $MCHS_MAKE_PROCESSES $QUIET_BUILD
		else
			make -j $MCHS_MAKE_PROCESSES $QUIET_BUILD ${MCHS_PKG_EXTRA_MAKE_ARGS}
		fi
	fi
}

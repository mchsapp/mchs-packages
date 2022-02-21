mchs_step_configure() {
	[ "$MCHS_PKG_METAPACKAGE" = "true" ] && return

	if [ "$MCHS_PKG_FORCE_CMAKE" = "false" ] && [ -f "$MCHS_PKG_SRCDIR/configure" ]; then
		if [ "$MCHS_CONTINUE_BUILD" == "true" ]; then
			return;
		fi
		mchs_step_configure_autotools
	elif [ "$MCHS_PKG_FORCE_CMAKE" = "true" ] || [ -f "$MCHS_PKG_SRCDIR/CMakeLists.txt" ]; then
		mchs_setup_cmake
		if [ "$MCHS_CMAKE_BUILD" = Ninja ]; then
			mchs_setup_ninja
		fi

		# Some packages, for example swift, uses cmake
		# internally, but cannot be configured with our
		# mchs_step_configure_cmake function (CMakeLists.txt
		# is not in src dir)
		if [ -f "$MCHS_PKG_SRCDIR/CMakeLists.txt" ] && \
			[ "$MCHS_CONTINUE_BUILD" == "false" ]; then
			mchs_step_configure_cmake
		fi
	elif [ -f "$MCHS_PKG_SRCDIR/meson.build" ]; then
		if [ "$MCHS_CONTINUE_BUILD" == "true" ]; then
			return;
		fi
		mchs_step_configure_meson
	fi
}

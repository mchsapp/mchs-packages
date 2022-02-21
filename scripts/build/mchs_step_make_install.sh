mchs_step_make_install() {
	[ "$MCHS_PKG_METAPACKAGE" = "true" ] && return

	if test -f build.ninja; then
		ninja -w dupbuild=warn -j $MCHS_MAKE_PROCESSES install
	elif ls ./*akefile &> /dev/null || [ -n "$MCHS_PKG_EXTRA_MAKE_ARGS" ]; then
		: "${MCHS_PKG_MAKE_INSTALL_TARGET:="install"}"
		# Some packages have problem with parallell install, and it does not buy much, so use -j 1.
		if [ -z "$MCHS_PKG_EXTRA_MAKE_ARGS" ]; then
			make -j 1 ${MCHS_PKG_MAKE_INSTALL_TARGET}
		else
			make -j 1 ${MCHS_PKG_EXTRA_MAKE_ARGS} ${MCHS_PKG_MAKE_INSTALL_TARGET}
		fi
	elif test -f Cargo.toml; then
		mchs_setup_rust
		cargo install \
			--jobs $MCHS_MAKE_PROCESSES \
			--path . \
			--force \
			--locked \
			--no-track \
			--target $CARGO_TARGET_NAME \
			--root $MCHS_PREFIX \
			$MCHS_PKG_EXTRA_CONFIGURE_ARGS
	fi
}

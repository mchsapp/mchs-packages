mchs_step_get_dependencies() {
	if [ "$MCHS_SKIP_DEPCHECK" = false ] && [ "$MCHS_INSTALL_DEPS" = true ] && [ "$MCHS_PKG_METAPACKAGE" = "false" ]; then
		# Download repo files
		mchs_get_repo_files

		# When doing build on device, ensure that apt lists are up-to-date.
		if [ "$MCHS_ON_DEVICE_BUILD" = "true" ]; then
			case "$MCHS_MAIN_PACKAGE_FORMAT" in
				"debian") apt update;;
				"pacman") pacman -Sy;;
			esac
		fi

		# Download dependencies
		while read PKG PKG_DIR; do
			if [ -z $PKG ]; then
				continue
			elif [ "$PKG" = "ERROR" ]; then
				mchs_error_exit "Obtaining buildorder failed"
			fi
			# llvm doesn't build if ndk-sysroot is installed:
			if [ "$PKG" = "ndk-sysroot" ]; then continue; fi
			read DEP_ARCH DEP_VERSION DEP_VERSION_PAC <<< $(mchs_extract_dep_info $PKG "${PKG_DIR}")

			if [ ! "$MCHS_QUIET_BUILD" = true ]; then
				echo "Downloading dependency $PKG@$DEP_VERSION if necessary..."
			fi

			if [ -e "$MCHS_BUILT_PACKAGES_DIRECTORY/$PKG" ]; then
				if [ "$(cat "$MCHS_BUILT_PACKAGES_DIRECTORY/$PKG")" = "$DEP_VERSION" ]; then
					continue
				fi
			fi

			if ! mchs_download_deb_pac $PKG $DEP_ARCH $DEP_VERSION $DEP_VERSION_PAC; then
				echo "Download of $PKG@$DEP_VERSION from $MCHS_REPO_URL failed, building instead"
				MCHS_BUILD_IGNORE_LOCK=true ./build-package.sh -I --format $MCHS_PACKAGE_FORMAT "${PKG_DIR}"
				continue
			fi
			if [ "$MCHS_ON_DEVICE_BUILD" = "false" ]; then
				if [ ! "$MCHS_QUIET_BUILD" = true ]; then
					echo "extracting $PKG..."
				fi
				(
					cd $MCHS_COMMON_CACHEDIR-$DEP_ARCH
					ar x ${PKG}_${DEP_VERSION}_${DEP_ARCH}.deb data.tar.xz
					if tar -tf data.tar.xz|grep "^./$">/dev/null; then
						# Strip prefixed ./, to avoid possible
						# permission errors from tar
						tar -xf data.tar.xz --strip-components=1 \
							--no-overwrite-dir -C /
					else
						tar -xf data.tar.xz --no-overwrite-dir -C /
					fi
				)
			fi

			mkdir -p $MCHS_BUILT_PACKAGES_DIRECTORY
			echo "$DEP_VERSION" > "$MCHS_BUILT_PACKAGES_DIRECTORY/$PKG"
		done<<<$(./scripts/buildorder.py -i "$MCHS_PKG_BUILDER_DIR" $MCHS_PACKAGES_DIRECTORIES || echo "ERROR")
	elif [ "$MCHS_SKIP_DEPCHECK" = false ] && [ "$MCHS_INSTALL_DEPS" = false ] && [ "$MCHS_PKG_METAPACKAGE" = "false" ]; then
		# Build dependencies
		while read PKG PKG_DIR; do
			if [ -z $PKG ]; then
				continue
			elif [ "$PKG" = "ERROR" ]; then
				mchs_error_exit "Obtaining buildorder failed"
			fi
			echo "Building dependency $PKG if necessary..."
			# Built dependencies are put in the default MCHS_OUTPUT_DIR instead of the specified one
			MCHS_BUILD_IGNORE_LOCK=true ./build-package.sh -s --format $MCHS_PACKAGE_FORMAT "${PKG_DIR}"
		done<<<$(./scripts/buildorder.py "$MCHS_PKG_BUILDER_DIR" $MCHS_PACKAGES_DIRECTORIES || echo "ERROR")
	fi
}

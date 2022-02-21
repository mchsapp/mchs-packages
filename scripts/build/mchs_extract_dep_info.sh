mchs_extract_dep_info() {
	PKG=$1
	PKG_DIR=$2
	if [ "$PKG" != "$(basename ${PKG_DIR})" ]; then
		# We are dealing with a subpackage
		MCHS_ARCH=$(
			# set MCHS_SUBPKG_PLATFORM_INDEPENDENT to
			# parent package's value and override if
			# needed
			MCHS_PKG_PLATFORM_INDEPENDENT=false
			source ${PKG_DIR}/build.sh
			MCHS_SUBPKG_PLATFORM_INDEPENDENT=$MCHS_PKG_PLATFORM_INDEPENDENT
			if [ "$MCHS_INSTALL_DEPS" = "false" ] || \
				   [ "$MCHS_PKG_NO_STATICSPLIT" = "true" ] || \
				   [ "${PKG/-static/}-static" != "${PKG}" ]; then
				source ${PKG_DIR}/${PKG}.subpackage.sh
			fi
			if [ "$MCHS_SUBPKG_PLATFORM_INDEPENDENT" = "true" ]; then
				echo all
			else
				echo $MCHS_ARCH
			fi
		)
	else
		MCHS_ARCH=$(
			MCHS_PKG_PLATFORM_INDEPENDENT="false"
			source ${PKG_DIR}/build.sh
			if [ "$MCHS_PKG_PLATFORM_INDEPENDENT" = "true" ]; then
				echo all
			else
				echo $MCHS_ARCH
			fi
		)
	fi
	(
		# debian version
		MCHS_PKG_REVISION="0"
		source ${PKG_DIR}/build.sh
		if [ "$MCHS_PKG_REVISION" != "0" ] || \
			   [ "$MCHS_PKG_VERSION" != "${MCHS_PKG_VERSION/-/}" ]; then
			MCHS_PKG_VERSION+="-$MCHS_PKG_REVISION"
		fi
		echo -n "${MCHS_ARCH} ${MCHS_PKG_VERSION} "
	)
	(
		# pacman version
		MCHS_PKG_REVISION="0"
		source ${PKG_DIR}/build.sh
		MCHS_PKG_VERSION_EDITED=${MCHS_PKG_VERSION//-/.}
		INCORRECT_SYMBOLS=$(echo $MCHS_PKG_VERSION_EDITED | grep -o '[0-9][a-z]')
		if [ -n "$INCORRECT_SYMBOLS" ]; then
			MCHS_PKG_VERSION_EDITED=${MCHS_PKG_VERSION_EDITED//${INCORRECT_SYMBOLS:0:1}${INCORRECT_SYMBOLS:1:1}/${INCORRECT_SYMBOLS:0:1}.${INCORRECT_SYMBOLS:1:1}}
		fi
		echo "${MCHS_PKG_VERSION_EDITED}-${MCHS_PKG_REVISION}"
	)
}

# Make script standalone executable as well as sourceable
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	mchs_extract_dep_info "$@"
fi

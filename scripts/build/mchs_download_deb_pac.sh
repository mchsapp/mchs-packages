mchs_download_deb_pac() {
	local PACKAGE=$1
	local PACKAGE_ARCH=$2
	local VERSION=$3
	local VERSION_PACMAN=$4

	if [ "$MCHS_ON_DEVICE_BUILD" = "true" ]; then
		case "$MCHS_MAIN_PACKAGE_FORMAT" in
			"debian") apt install -y "${PACKAGE}=${VERSION}";;
			"pacman") pacman -S "${PACKAGE}=${VERSION_PACMAN}" --needed --noconfirm;;
		esac
		return "$?"
	fi

	local DEB_FILE="${PACKAGE}_${VERSION}_${PACKAGE_ARCH}.deb"
	PKG_HASH=""

	for idx in $(seq ${#MCHS_REPO_URL[@]}); do
		local MCHS_REPO_NAME=$(echo ${MCHS_REPO_URL[$idx-1]} | sed -e 's%https://%%g' -e 's%http://%%g' -e 's%/%-%g')
		local PACKAGE_FILE_PATH="${MCHS_REPO_NAME}-${MCHS_REPO_DISTRIBUTION[$idx-1]}-${MCHS_REPO_COMPONENT[$idx-1]}-Packages"
		if [ ! -f "${MCHS_COMMON_CACHEDIR}-${PACKAGE_ARCH}/${PACKAGE_FILE_PATH}" ] && \
			[ -f "${MCHS_COMMON_CACHEDIR}-aarch64/${PACKAGE_FILE_PATH}" ]; then
			# Packages file for $PACKAGE_ARCH did not
			# exist. Could be an aptly mirror where the
			# all arch is mixed into the other arches,
			# check for package in aarch64 Packages
			# instead.
			read -d "\n" PKG_PATH PKG_HASH <<<$(./scripts/get_hash_from_file.py "${MCHS_COMMON_CACHEDIR}-aarch64/$PACKAGE_FILE_PATH" $PACKAGE $VERSION)
			if [ -n "$PKG_HASH" ]; then
				if [ ! "$MCHS_QUIET_BUILD" = true ]; then
					echo "Found $PACKAGE in ${MCHS_REPO_URL[$idx-1]}/dists/${MCHS_REPO_DISTRIBUTION[$idx-1]}"
				fi
				break
			fi
		elif [ -f "${MCHS_COMMON_CACHEDIR}-${PACKAGE_ARCH}/${PACKAGE_FILE_PATH}" ]; then
			read -d "\n" PKG_PATH PKG_HASH <<<$(./scripts/get_hash_from_file.py "${MCHS_COMMON_CACHEDIR}-${PACKAGE_ARCH}/$PACKAGE_FILE_PATH" $PACKAGE $VERSION)
			if [ -n "$PKG_HASH" ]; then
				if [ ! "$MCHS_QUIET_BUILD" = true ]; then
					echo "Found $PACKAGE in ${MCHS_REPO_URL[$idx-1]}/dists/${MCHS_REPO_DISTRIBUTION[$idx-1]}"
				fi
				break
			fi
		fi
	done

	if [ "$PKG_HASH" = "" ]; then
		return 1
	fi

	mchs_download "${MCHS_REPO_URL[${idx}-1]}/${PKG_PATH}" \
				"${MCHS_COMMON_CACHEDIR}-${PACKAGE_ARCH}/${DEB_FILE}" \
				"$PKG_HASH"
}

# Make script standalone executable as well as sourceable
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	mchs_download "$@"
fi

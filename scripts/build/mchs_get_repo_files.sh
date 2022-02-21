mchs_get_repo_files() {
	# Not needed for on-device builds or when building
	# dependencies.
	if [ "$MCHS_ON_DEVICE_BUILD" = "true" ] || [ "$MCHS_INSTALL_DEPS" = "false" ]; then
		return
	fi

	for idx in $(seq ${#MCHS_REPO_URL[@]}); do
		local MCHS_REPO_NAME=$(echo ${MCHS_REPO_URL[$idx-1]} | sed -e 's%https://%%g' -e 's%http://%%g' -e 's%/%-%g')
		local RELEASE_FILE=${MCHS_COMMON_CACHEDIR}/${MCHS_REPO_NAME}-${MCHS_REPO_DISTRIBUTION[$idx-1]}-Release
		local repo_base="${MCHS_REPO_URL[$idx-1]}/dists/${MCHS_REPO_DISTRIBUTION[$idx-1]}"
		local dl_prefix="${MCHS_REPO_NAME}-${MCHS_REPO_DISTRIBUTION[$idx-1]}-${MCHS_REPO_COMPONENT[$idx-1]}"

		local download_attempts=6
		while ((download_attempts > 0)); do
			if mchs_download "${repo_base}/Release" \
				"$RELEASE_FILE" SKIP_CHECKSUM && \
				mchs_download "${repo_base}/Release.gpg" \
				"${RELEASE_FILE}.gpg" SKIP_CHECKSUM; then

				if ! gpg --verify "${RELEASE_FILE}.gpg" "$RELEASE_FILE"; then
					mchs_error_exit "failed to verify gpg signature of $RELEASE_FILE"
				fi

				local failed=false
				for arch in all $MCHS_ARCH; do
					local PACKAGES_HASH=$(./scripts/get_hash_from_file.py ${RELEASE_FILE} $arch ${MCHS_REPO_COMPONENT[$idx-1]})

					# If packages_hash = "" then the repo probably doesn't contain debs for $arch
					if [ -n "$PACKAGES_HASH" ]; then
						if ! mchs_download "${repo_base}/${MCHS_REPO_COMPONENT[$idx-1]}/binary-$arch/Packages" \
							"${MCHS_COMMON_CACHEDIR}-$arch/${dl_prefix}-Packages" \
							$PACKAGES_HASH; then
							failed=true
							break
						fi
					fi
				done

				if ! $failed; then
					break
				fi
			fi

			download_attempts=$((download_attempts - 1))
			if ((download_attempts < 1)); then
				mchs_error_exit "Failed to download package repository metadata. Try to build without -i/-I option."
			fi

			echo "Retrying download in 30 seconds (${download_attempts} attempts left)..." >&2
			sleep 30
		done

	done
}

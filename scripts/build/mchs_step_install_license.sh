mchs_step_install_license() {
	[ "$MCHS_PKG_METAPACKAGE" = "true" ] && return

	mkdir -p "$MCHS_PREFIX/share/doc/$MCHS_PKG_NAME"
	local LICENSE
	local COUNTER=0
	if [ ! "${MCHS_PKG_LICENSE_FILE}" = "" ]; then
		INSTALLED_LICENSES=()
		COUNTER=1
		while read -r LICENSE; do
			if [ ! -f "$MCHS_PKG_SRCDIR/$LICENSE" ]; then
				mchs_error_exit "$MCHS_PKG_SRCDIR/$LICENSE does not exist"
			fi
			if [[ " ${INSTALLED_LICENSES[@]} " =~ " $(basename $LICENSE) " ]]; then
				# We have already installed a license file named $(basename $LICENSE) so add a suffix to it
				TARGET="$MCHS_PREFIX/share/doc/${MCHS_PKG_NAME}/$(basename $LICENSE).$COUNTER"
				COUNTER=$((COUNTER + 1))
			else
				TARGET="$MCHS_PREFIX/share/doc/${MCHS_PKG_NAME}/$(basename $LICENSE)"
				INSTALLED_LICENSES+=("$(basename $LICENSE)")
			fi
			cp -f "${MCHS_PKG_SRCDIR}/${LICENSE}" "$TARGET"
		done < <(echo "$MCHS_PKG_LICENSE_FILE" | sed "s/,/\n/g")
	else
		while read -r LICENSE; do
			# These licenses contain copyright information, so
			# we cannot use a generic license file
			if [ "$LICENSE" == "MIT" ] || \
				[ "$LICENSE" == "ISC" ] || \
				[ "$LICENSE" == "PythonPL" ] || \
				[ "$LICENSE" == "Openfont-1.1" ] || \
				[ "$LICENSE" == "ZLIB" ] || \
				[ "$LICENSE" == "Libpng" ] || \
				[ "$LICENSE" == "BSD" ] || \
				[ "$LICENSE" == "BSD 2-Clause" ] || \
				[ "$LICENSE" == "BSD 3-Clause" ] || \
				[ "$LICENSE" == "BSD Simplified" ]; then
			    for FILE in LICENSE \
                                            LICENSE.md \
                                            LICENSE.txt \
                                            LICENSE.TXT \
                                            COPYING \
                                            COPYRIGHT \
                                            Copyright.txt \
                                            Copyright \
                                            LICENCE \
                                            License \
                                            license \
                                            license.md \
                                            License.txt \
                                            license.txt \
                                            licence; do
					if [ -f "$MCHS_PKG_SRCDIR/$FILE" ]; then
						if [[ $COUNTER -gt 0 ]]; then
							cp -f "${MCHS_PKG_SRCDIR}/$FILE" "${MCHS_PREFIX}/share/doc/${MCHS_PKG_NAME}/LICENSE.${COUNTER}"
						else
							cp -f "${MCHS_PKG_SRCDIR}/$FILE" "${MCHS_PREFIX}/share/doc/${MCHS_PKG_NAME}/LICENSE"
						fi
						COUNTER=$((COUNTER + 1))
					fi
				done
			elif [ -f "$MCHS_SCRIPTDIR/packages/mchs-licenses/LICENSES/${LICENSE}.txt" ]; then
				if [[ $COUNTER -gt 0 ]]; then
					ln -sf "../../LICENSES/${LICENSE}.txt" "$MCHS_PREFIX/share/doc/$MCHS_PKG_NAME/LICENSE.${COUNTER}"
				else
					ln -sf "../../LICENSES/${LICENSE}.txt" "$MCHS_PREFIX/share/doc/$MCHS_PKG_NAME/LICENSE"
				fi
				COUNTER=$((COUNTER + 1))
			fi
		done < <(echo "$MCHS_PKG_LICENSE" | sed "s/,/\n/g")

		for LICENSE in "$MCHS_PREFIX/share/doc/$MCHS_PKG_NAME"/LICENSE*; do
			if [ "$LICENSE" = "$MCHS_PREFIX/share/doc/$MCHS_PKG_NAME/LICENSE*" ]; then
				mchs_error_exit "No LICENSE file was installed for $MCHS_PKG_NAME"
			fi
		done
	fi
}

mchs_create_debian_subpackages() {
	# Sub packages:
	if [ "$MCHS_PKG_NO_STATICSPLIT" = "false" ] && [[ -n $(shopt -s globstar; shopt -s nullglob; echo lib/**/*.a) ]]; then
		# Add virtual -static sub package if there are include files:
		local _STATIC_SUBPACKAGE_FILE=$MCHS_PKG_TMPDIR/${MCHS_PKG_NAME}-static.subpackage.sh
		echo MCHS_SUBPKG_INCLUDE=\"lib/**/*.a lib/**/*.la\" > "$_STATIC_SUBPACKAGE_FILE"
		echo "MCHS_SUBPKG_DESCRIPTION=\"Static libraries for ${MCHS_PKG_NAME}\"" >> "$_STATIC_SUBPACKAGE_FILE"
	fi

	# Now build all sub packages
	rm -Rf "$MCHS_TOPDIR/$MCHS_PKG_NAME/subpackages"
	for subpackage in $MCHS_PKG_BUILDER_DIR/*.subpackage.sh $MCHS_PKG_TMPDIR/*subpackage.sh; do
		test ! -f "$subpackage" && continue
		local SUB_PKG_NAME
		SUB_PKG_NAME=$(basename "$subpackage" .subpackage.sh)
		# Default value is same as main package, but sub package may override:
		local MCHS_SUBPKG_PLATFORM_INDEPENDENT=$MCHS_PKG_PLATFORM_INDEPENDENT
		local SUB_PKG_DIR=$MCHS_TOPDIR/$MCHS_PKG_NAME/subpackages/$SUB_PKG_NAME
		local MCHS_SUBPKG_ESSENTIAL=false
		local MCHS_SUBPKG_BREAKS=""
		local MCHS_SUBPKG_DEPENDS=""
		local MCHS_SUBPKG_CONFLICTS=""
		local MCHS_SUBPKG_REPLACES=""
		local MCHS_SUBPKG_CONFFILES=""
		local MCHS_SUBPKG_DEPEND_ON_PARENT=""
		local SUB_PKG_MASSAGE_DIR=$SUB_PKG_DIR/massage/$MCHS_PREFIX
		local SUB_PKG_PACKAGE_DIR=$SUB_PKG_DIR/package
		mkdir -p "$SUB_PKG_MASSAGE_DIR" "$SUB_PKG_PACKAGE_DIR"

		# shellcheck source=/dev/null
		source "$subpackage"

		# Allow globstar (i.e. './**/') patterns.
		shopt -s globstar
		for includeset in $MCHS_SUBPKG_INCLUDE; do
			local _INCLUDE_DIRSET
			_INCLUDE_DIRSET=$(dirname "$includeset")
			test "$_INCLUDE_DIRSET" = "." && _INCLUDE_DIRSET=""

			if [ -e "$includeset" ] || [ -L "$includeset" ]; then
				# Add the -L clause to handle relative symbolic links:
				mkdir -p "$SUB_PKG_MASSAGE_DIR/$_INCLUDE_DIRSET"
				mv "$includeset" "$SUB_PKG_MASSAGE_DIR/$_INCLUDE_DIRSET"
			fi
		done
		shopt -u globstar

		local SUB_PKG_ARCH=$MCHS_ARCH
		[ "$MCHS_SUBPKG_PLATFORM_INDEPENDENT" = "true" ] && SUB_PKG_ARCH=all

		cd "$SUB_PKG_DIR/massage"
		local SUB_PKG_INSTALLSIZE
		SUB_PKG_INSTALLSIZE=$(du -sk . | cut -f 1)
		tar -cJf "$SUB_PKG_PACKAGE_DIR/data.tar.xz" .

		mkdir -p DEBIAN
		cd DEBIAN

		cat > control <<-HERE
			Package: $SUB_PKG_NAME
			Architecture: ${SUB_PKG_ARCH}
			Installed-Size: ${SUB_PKG_INSTALLSIZE}
			Maintainer: $MCHS_PKG_MAINTAINER
			Version: $MCHS_PKG_FULLVERSION
			Homepage: $MCHS_PKG_HOMEPAGE
		HERE

		local PKG_DEPS_SPC=" ${MCHS_PKG_DEPENDS//,/} "

		if [ -z "$MCHS_SUBPKG_DEPEND_ON_PARENT" ] && [ "${PKG_DEPS_SPC/ $SUB_PKG_NAME /}" = "$PKG_DEPS_SPC" ]; then
		    MCHS_SUBPKG_DEPENDS+=", $MCHS_PKG_NAME (= $MCHS_PKG_FULLVERSION)"
		elif [ "$MCHS_SUBPKG_DEPEND_ON_PARENT" = unversioned ]; then
		    MCHS_SUBPKG_DEPENDS+=", $MCHS_PKG_NAME"
		elif [ "$MCHS_SUBPKG_DEPEND_ON_PARENT" = deps ]; then
		    MCHS_SUBPKG_DEPENDS+=", $MCHS_PKG_DEPENDS"
		fi

		[ "$MCHS_SUBPKG_ESSENTIAL" = "true" ] && echo "Essential: yes" >> control
		test ! -z "$MCHS_SUBPKG_DEPENDS" && echo "Depends: ${MCHS_SUBPKG_DEPENDS/#, /}" >> control
		test ! -z "$MCHS_SUBPKG_BREAKS" && echo "Breaks: $MCHS_SUBPKG_BREAKS" >> control
		test ! -z "$MCHS_SUBPKG_CONFLICTS" && echo "Conflicts: $MCHS_SUBPKG_CONFLICTS" >> control
		test ! -z "$MCHS_SUBPKG_REPLACES" && echo "Replaces: $MCHS_SUBPKG_REPLACES" >> control
		echo "Description: $MCHS_SUBPKG_DESCRIPTION" >> control

		for f in $MCHS_SUBPKG_CONFFILES; do echo "$MCHS_PREFIX/$f" >> conffiles; done

		# Allow packages to create arbitrary control files.
		mchs_step_create_subpkg_debscripts

		# Create control.tar.xz
		tar -cJf "$SUB_PKG_PACKAGE_DIR/control.tar.xz" -H gnu .

		# Create the actual .deb file:
		MCHS_SUBPKG_DEBFILE=$MCHS_OUTPUT_DIR/${SUB_PKG_NAME}${DEBUG}_${MCHS_PKG_FULLVERSION}_${SUB_PKG_ARCH}.deb
		test ! -f "$MCHS_COMMON_CACHEDIR/debian-binary" && echo "2.0" > "$MCHS_COMMON_CACHEDIR/debian-binary"
		${AR-ar} cr "$MCHS_SUBPKG_DEBFILE" \
				   "$MCHS_COMMON_CACHEDIR/debian-binary" \
				   "$SUB_PKG_PACKAGE_DIR/control.tar.xz" \
				   "$SUB_PKG_PACKAGE_DIR/data.tar.xz"

		# Go back to main package:
		cd "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX"
	done
}

mchs_create_pacman_subpackages() {
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
		local MCHS_SUBPKG_GROUPS=""
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
		[ "$MCHS_SUBPKG_PLATFORM_INDEPENDENT" = "true" ] && SUB_PKG_ARCH=any

		cd "$SUB_PKG_DIR/massage"
		local SUB_PKG_INSTALLSIZE
		SUB_PKG_INSTALLSIZE=$(du -bs . | cut -f 1)

		local BUILD_DATE
		BUILD_DATE=$(date +%s)

		local PKG_DEPS_SPC=" ${MCHS_PKG_DEPENDS//,/} "
		if [ -z "$MCHS_SUBPKG_DEPEND_ON_PARENT" ] && [ "${PKG_DEPS_SPC/ $SUB_PKG_NAME /}" = "$PKG_DEPS_SPC" ]; then
			# Does pacman supports versioned dependencies?
			#MCHS_SUBPKG_DEPENDS+=", $MCHS_PKG_NAME (= $MCHS_PKG_FULLVERSION)"
			MCHS_SUBPKG_DEPENDS+=", $MCHS_PKG_NAME"
		elif [ "$MCHS_SUBPKG_DEPEND_ON_PARENT" = unversioned ]; then
			MCHS_SUBPKG_DEPENDS+=", $MCHS_PKG_NAME"
		elif [ "$MCHS_SUBPKG_DEPEND_ON_PARENT" = deps ]; then
			MCHS_SUBPKG_DEPENDS+=", $MCHS_PKG_DEPENDS"
		fi

		# Package metadata.
		{
			echo "pkgname = $SUB_PKG_NAME"
			echo "pkgbase = $MCHS_PKG_NAME"
			echo "pkgver = $MCHS_PKG_FULLVERSION_FOR_PACMAN"
			echo "pkgdesc = $(echo "$MCHS_SUBPKG_DESCRIPTION" | tr '\n' ' ')"
			echo "url = $MCHS_PKG_HOMEPAGE"
			echo "builddate = $BUILD_DATE"
			echo "packager = $MCHS_PKG_MAINTAINER"
			echo "size = $SUB_PKG_INSTALLSIZE"
			echo "arch = $SUB_PKG_ARCH"

			if [ -n "$MCHS_SUBPKG_REPLACES" ]; then
				tr ',' '\n' <<< "$MCHS_SUBPKG_REPLACES" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "replaces = %s\n", $1 }'
			fi

			if [ -n "$MCHS_SUBPKG_CONFLICTS" ]; then
				tr ',' '\n' <<< "$MCHS_SUBPKG_CONFLICTS" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "conflict = %s\n", $1 }'
			fi

			if [ -n "$MCHS_SUBPKG_BREAKS" ]; then
				tr ',' '\n' <<< "$MCHS_SUBPKG_BREAKS" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "conflict = %s\n", $1 }'
			fi

			if [ -n "$MCHS_SUBPKG_DEPENDS" ]; then
				tr ',' '\n' <<< "${MCHS_SUBPKG_DEPENDS/#, /}" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "depend = %s\n", $1 }' | sed 's/|.*//'
			fi

			if [ -n "$MCHS_SUBPKG_CONFFILES" ]; then
				tr ',' '\n' <<< "$MCHS_SUBPKG_CONFFILES" | awk '{ printf "backup = '"${MCHS_PREFIX:1}"'/%s\n", $1 }'
			fi

			if [ -n "$MCHS_SUBPKG_GROUPS" ]; then
				tr ',' '\n' <<< "${MCHS_SUBPKG_GROUPS/#, /}" | awk '{ printf "group = %s\n", $1 }'
			fi
		} > .PKGINFO

		# Build metadata.
		{
			echo "format = 2"
			echo "pkgname = $SUB_PKG_NAME"
			echo "pkgbase = $MCHS_PKG_NAME"
			echo "pkgver = $MCHS_PKG_FULLVERSION_FOR_PACMAN"
			echo "pkgarch = $SUB_PKG_ARCH"
			echo "packager = $MCHS_PKG_MAINTAINER"
			echo "builddate = $BUILD_DATE"
		} > .BUILDINFO

		# Write package installation hooks.
		mchs_step_create_subpkg_debscripts
		mchs_step_create_pacman_install_hook

		# Configuring the selection of a copress for a batch.
		local COMPRESS
		local PKG_FORMAT
		case $MCHS_PACMAN_PACKAGE_COMPRESSION in
			"gzip")
				COMPRESS=(gzip -c -f -n)
				PKG_FORMAT="gz";;
			"bzip2")
				COMPRESS=(bzip2 -c -f)
				PKG_FORMAT="bz2";;
			"zstd")
				COMPRESS=(zstd -c -z -q -)
				PKG_FORMAT="zst";;
			"lrzip")
				COMPRESS=(lrzip -q)
				PKG_FORMAT="lrz";;
			"lzop")
				COMPRESS=(lzop -q)
				PKG_FORMAT="lzop";;
			"lz4")
				COMPRESS=(lz4 -q)
				PKG_FORMAT="lz4";;
			"lzip")
				COMPRESS=(lzip -c -f)
				PKG_FORMAT="lz";;
			"xz" | *)
				COMPRESS=(xz -c -z -)
				PKG_FORMAT="xz";;
		esac

		# Create the actual .pkg file:
		local MCHS_SUBPKG_PACMAN_FILE=$MCHS_OUTPUT_DIR/${SUB_PKG_NAME}${DEBUG}-${MCHS_PKG_FULLVERSION_FOR_PACMAN}-${SUB_PKG_ARCH}.pkg.tar.${PKG_FORMAT}
		shopt -s dotglob globstar
		printf '%s\0' **/* | bsdtar -cnf - --format=mtree \
			--options='!all,use-set,type,uid,gid,mode,time,size,md5,sha256,link' \
			--null --files-from - --exclude .MTREE | \
			gzip -c -f -n > .MTREE
		printf '%s\0' **/* | bsdtar --no-fflags -cnf - --null --files-from - | \
			$COMPRESS > "$MCHS_SUBPKG_PACMAN_FILE"
		shopt -u dotglob globstar

		# Go back to main package:
		cd "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX"
	done
}

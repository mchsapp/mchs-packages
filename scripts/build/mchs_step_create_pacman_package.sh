mchs_step_create_pacman_package() {
	local MCHS_PKG_INSTALLSIZE
	MCHS_PKG_INSTALLSIZE=$(du -bs . | cut -f 1)

	# From here on MCHS_ARCH is set to "all" if MCHS_PKG_PLATFORM_INDEPENDENT is set by the package
	[ "$MCHS_PKG_PLATFORM_INDEPENDENT" = "true" ] && MCHS_ARCH=any

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

	local PACMAN_FILE=$MCHS_OUTPUT_DIR/${MCHS_PKG_NAME}${DEBUG}-${MCHS_PKG_FULLVERSION_FOR_PACMAN}-${MCHS_ARCH}.pkg.tar.${PKG_FORMAT}

	local BUILD_DATE
	BUILD_DATE=$(date +%s)

	# Package metadata.
	{
		echo "pkgname = $MCHS_PKG_NAME"
		echo "pkgbase = $MCHS_PKG_NAME"
		echo "pkgver = $MCHS_PKG_FULLVERSION_FOR_PACMAN"
		echo "pkgdesc = $(echo "$MCHS_PKG_DESCRIPTION" | tr '\n' ' ')"
		echo "url = $MCHS_PKG_HOMEPAGE"
		echo "builddate = $BUILD_DATE"
		echo "packager = $MCHS_PKG_MAINTAINER"
		echo "size = $MCHS_PKG_INSTALLSIZE"
		echo "arch = $MCHS_ARCH"

		if [ -n "$MCHS_PKG_LICENSE" ]; then
			tr ',' '\n' <<< "$MCHS_PKG_LICENSE" | awk '{ printf "license = %s\n", $0 }'
		fi

		if [ -n "$MCHS_PKG_REPLACES" ]; then
			tr ',' '\n' <<< "$MCHS_PKG_REPLACES" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "replaces = %s\n", $1 }'
		fi

		if [ -n "$MCHS_PKG_CONFLICTS" ]; then
			tr ',' '\n' <<< "$MCHS_PKG_CONFLICTS" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "conflict = %s\n", $1 }'
		fi

		if [ -n "$MCHS_PKG_BREAKS" ]; then
			tr ',' '\n' <<< "$MCHS_PKG_BREAKS" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "conflict = %s\n", $1 }'
		fi

		if [ -n "$MCHS_PKG_PROVIDES" ]; then
			tr ',' '\n' <<< "$MCHS_PKG_PROVIDES" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "provides = %s\n", $1 }'
		fi

		if [ -n "$MCHS_PKG_DEPENDS" ]; then
			tr ',' '\n' <<< "$MCHS_PKG_DEPENDS" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "depend = %s\n", $1 }' | sed 's/|.*//'
		fi

		if [ -n "$MCHS_PKG_RECOMMENDS" ]; then
			tr ',' '\n' <<< "$MCHS_PKG_RECOMMENDS" | awk '{ printf "optdepend = %s\n", $1 }'
		fi

		if [ -n "$MCHS_PKG_SUGGESTS" ]; then
			tr ',' '\n' <<< "$MCHS_PKG_SUGGESTS" | awk '{ printf "optdepend = %s\n", $1 }'
		fi

		if [ -n "$MCHS_PKG_BUILD_DEPENDS" ]; then
			tr ',' '\n' <<< "$MCHS_PKG_BUILD_DEPENDS" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "makedepend = %s\n", $1 }'
		fi

		if [ -n "$MCHS_PKG_CONFFILES" ]; then
			tr ',' '\n' <<< "$MCHS_PKG_CONFFILES" | awk '{ printf "backup = '"${MCHS_PREFIX:1}"'/%s\n", $1 }'
		fi

		if [ -n "$MCHS_PKG_GROUPS" ]; then
			tr ',' '\n' <<< "${MCHS_PKG_GROUPS/#, /}" | awk '{ printf "group = %s\n", $1 }'
		fi
	} > .PKGINFO

	# Build metadata.
	{
		echo "format = 2"
		echo "pkgname = $MCHS_PKG_NAME"
		echo "pkgbase = $MCHS_PKG_NAME"
		echo "pkgver = $MCHS_PKG_FULLVERSION_FOR_PACMAN"
		echo "pkgarch = $MCHS_ARCH"
		echo "packager = $MCHS_PKG_MAINTAINER"
		echo "builddate = $BUILD_DATE"
	} > .BUILDINFO

	# Write installation hooks.
	mchs_step_create_debscripts
	mchs_step_create_pacman_install_hook

	# Create package
	shopt -s dotglob globstar
	printf '%s\0' **/* | bsdtar -cnf - --format=mtree \
		--options='!all,use-set,type,uid,gid,mode,time,size,md5,sha256,link' \
		--null --files-from - --exclude .MTREE | \
		gzip -c -f -n > .MTREE
	printf '%s\0' **/* | bsdtar --no-fflags -cnf - --null --files-from - | \
		$COMPRESS > "$PACMAN_FILE"
	shopt -u dotglob globstar
}

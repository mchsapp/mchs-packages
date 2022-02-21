mchs_step_create_debian_package() {
	if [ "$MCHS_PKG_METAPACKAGE" = "true" ]; then
		# Metapackage doesn't have data inside.
		rm -rf data
	fi
        tar -cJf "$MCHS_PKG_PACKAGEDIR/data.tar.xz" -H gnu .

	# Get install size. This will be written as the "Installed-Size" deb field so is measured in 1024-byte blocks:
	local MCHS_PKG_INSTALLSIZE
	MCHS_PKG_INSTALLSIZE=$(du -sk . | cut -f 1)

	# From here on MCHS_ARCH is set to "all" if MCHS_PKG_PLATFORM_INDEPENDENT is set by the package
	[ "$MCHS_PKG_PLATFORM_INDEPENDENT" = "true" ] && MCHS_ARCH=all

	mkdir -p DEBIAN
	cat > DEBIAN/control <<-HERE
		Package: $MCHS_PKG_NAME
		Architecture: ${MCHS_ARCH}
		Installed-Size: ${MCHS_PKG_INSTALLSIZE}
		Maintainer: $MCHS_PKG_MAINTAINER
		Version: $MCHS_PKG_FULLVERSION
		Homepage: $MCHS_PKG_HOMEPAGE
	HERE
	test ! -z "$MCHS_PKG_BREAKS" && echo "Breaks: $MCHS_PKG_BREAKS" >> DEBIAN/control
	test ! -z "$MCHS_PKG_PRE_DEPENDS" && echo "Pre-Depends: $MCHS_PKG_PRE_DEPENDS" >> DEBIAN/control
	test ! -z "$MCHS_PKG_DEPENDS" && echo "Depends: $MCHS_PKG_DEPENDS" >> DEBIAN/control
	[ "$MCHS_PKG_ESSENTIAL" = "true" ] && echo "Essential: yes" >> DEBIAN/control
	test ! -z "$MCHS_PKG_CONFLICTS" && echo "Conflicts: $MCHS_PKG_CONFLICTS" >> DEBIAN/control
	test ! -z "$MCHS_PKG_RECOMMENDS" && echo "Recommends: $MCHS_PKG_RECOMMENDS" >> DEBIAN/control
	test ! -z "$MCHS_PKG_REPLACES" && echo "Replaces: $MCHS_PKG_REPLACES" >> DEBIAN/control
	test ! -z "$MCHS_PKG_PROVIDES" && echo "Provides: $MCHS_PKG_PROVIDES" >> DEBIAN/control
	test ! -z "$MCHS_PKG_SUGGESTS" && echo "Suggests: $MCHS_PKG_SUGGESTS" >> DEBIAN/control
	echo "Description: $MCHS_PKG_DESCRIPTION" >> DEBIAN/control

	# Create DEBIAN/conffiles (see https://www.debian.org/doc/debian-policy/ap-pkg-conffiles.html):
	for f in $MCHS_PKG_CONFFILES; do echo "$MCHS_PREFIX/$f" >> DEBIAN/conffiles; done

	# Allow packages to create arbitrary control files.
	# XXX: Should be done in a better way without a function?
	cd DEBIAN
	mchs_step_create_debscripts

	# Create control.tar.xz
	tar -cJf "$MCHS_PKG_PACKAGEDIR/control.tar.xz" -H gnu .

	test ! -f "$MCHS_COMMON_CACHEDIR/debian-binary" && echo "2.0" > "$MCHS_COMMON_CACHEDIR/debian-binary"
	MCHS_PKG_DEBFILE=$MCHS_OUTPUT_DIR/${MCHS_PKG_NAME}${DEBUG}_${MCHS_PKG_FULLVERSION}_${MCHS_ARCH}.deb
	# Create the actual .deb file:
	${AR-ar} cr "$MCHS_PKG_DEBFILE" \
	       "$MCHS_COMMON_CACHEDIR/debian-binary" \
	       "$MCHS_PKG_PACKAGEDIR/control.tar.xz" \
	       "$MCHS_PKG_PACKAGEDIR/data.tar.xz"
}

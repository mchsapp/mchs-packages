MCHS_PKG_HOMEPAGE=https://docbook.org/
MCHS_PKG_DESCRIPTION="XML stylesheets for Docbook-xml transformations"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_VERSION=1.79.2
MCHS_PKG_LICENSE_FILE="docbook-xsl-${MCHS_PKG_VERSION}/COPYING, docbook-xsl-nons-${MCHS_PKG_VERSION}/COPYING"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_REVISION=1
MCHS_PKG_DEPENDS="docbook-xml, libxml2-utils, xsltproc"
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_SKIP_SRC_EXTRACT=true

mchs_step_get_source() {
	mkdir -p $MCHS_PKG_SRCDIR

	cd $MCHS_PKG_SRCDIR

	mchs_download "https://github.com/docbook/xslt10-stylesheets/releases/download/release%2F${MCHS_PKG_VERSION}/docbook-xsl-$MCHS_PKG_VERSION.tar.gz" \
		$MCHS_PKG_CACHEDIR/docbook-xsl-$MCHS_PKG_VERSION.tar.gz \
		966188d7c05fc76eaca115a55893e643dd01a3486f6368733c9ad974fcee7a26

	tar xf $MCHS_PKG_CACHEDIR/docbook-xsl-$MCHS_PKG_VERSION.tar.gz

	mchs_download "https://github.com/docbook/xslt10-stylesheets/releases/download/release%2F${MCHS_PKG_VERSION}/docbook-xsl-nons-$MCHS_PKG_VERSION.tar.gz" \
		$MCHS_PKG_CACHEDIR/docbook-xsl-nons-$MCHS_PKG_VERSION.tar.gz \
		f89425b44e48aad24319a2f0d38e0cb6059fdc7dbaf31787c8346c748175ca8e

	tar xf $MCHS_PKG_CACHEDIR/docbook-xsl-nons-$MCHS_PKG_VERSION.tar.gz
}

mchs_step_patch_package() {
	cd $MCHS_PKG_SRCDIR/docbook-xsl-$MCHS_PKG_VERSION
	patch -Np2 -i $MCHS_PKG_BUILDER_DIR/765567_non-recursive_string_subst.patch

	cd $MCHS_PKG_SRCDIR/docbook-xsl-nons-$MCHS_PKG_VERSION
	patch -Np2 -i $MCHS_PKG_BUILDER_DIR/765567_non-recursive_string_subst.patch
}

mchs_step_make_install() {
	local pkgroot ns dir

	for ns in -nons ''; do
		pkgroot="$MCHS_PREFIX/share/xml/docbook/xsl-stylesheets-${MCHS_PKG_VERSION}${ns}"
		dir=docbook-xsl${ns}-${MCHS_PKG_VERSION}

		install -Dt "$pkgroot" -m600 $dir/VERSION{,.xsl}

		(
			shopt -s nullglob  # ignore missing files
			for fn in assembly common eclipse epub epub3 fo highlighting html \
				htmlhelp javahelp lib manpages params profiling roundtrip template \
				website xhtml xhtml-1_1 xhtml5
			do
				install -Dt "${pkgroot}/${fn}" -m600 ${dir}/${fn}/*.{xml,xsl,dtd,ent}
			done
		)
	done
}

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ]; then
		if [ ! -e "$MCHS_PREFIX/etc/xml/catalog" ]; then
			xmlcatalog --noout --create "$MCHS_PREFIX/etc/xml/catalog"
		else
			xmlcatalog --noout --del "$MCHS_PREFIX/share/xml/docbook/xsl-stylesheets-$MCHS_PKG_VERSION" \
				"$MCHS_PREFIX/etc/xml/catalog"
		fi

		for ver in $MCHS_PKG_VERSION current; do
			for x in rewriteSystem rewriteURI; do
				xmlcatalog --noout --add \$x http://cdn.docbook.org/release/xsl/\$ver \
					"$MCHS_PREFIX/share/xml/docbook/xsl-stylesheets-$MCHS_PKG_VERSION" \
					"$MCHS_PREFIX/etc/xml/catalog"

				xmlcatalog --noout --add \$x http://docbook.sourceforge.net/release/xsl-ns/\$ver \
					"$MCHS_PREFIX/share/xml/docbook/xsl-stylesheets-$MCHS_PKG_VERSION" \
					"$MCHS_PREFIX/etc/xml/catalog"

				xmlcatalog --noout --add \$x http://docbook.sourceforge.net/release/xsl/\$ver \
					"$MCHS_PREFIX/share/xml/docbook/xsl-stylesheets-${MCHS_PKG_VERSION}-nons" \
					"$MCHS_PREFIX/etc/xml/catalog"
			done
		done
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "remove" ]; then
		xmlcatalog --noout --del "$MCHS_PREFIX/share/xml/docbook/xsl-stylesheets-$MCHS_PKG_VERSION" \
			"$MCHS_PREFIX/etc/xml/catalog"
	fi
	EOF
}

MCHS_PKG_HOMEPAGE=https://www.oasis-open.org/docbook/
MCHS_PKG_DESCRIPTION="A widely used XML scheme for writing documentation and help"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.5
MCHS_PKG_REVISION=4
MCHS_PKG_DEPENDS="libxml2-utils"
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_SKIP_SRC_EXTRACT=true

mchs_step_get_source() {
	mchs_download "https://docbook.org/xml/4.1.2/docbkx412.zip" \
		$MCHS_PKG_CACHEDIR/docbkx412.zip \
		30f0644064e0ea71751438251940b1431f46acada814a062870f486c772e7772
	mchs_download "https://docbook.org/xml/4.2/docbook-xml-4.2.zip" \
		$MCHS_PKG_CACHEDIR/docbook-xml-4.2.zip \
		acc4601e4f97a196076b7e64b368d9248b07c7abf26b34a02cca40eeebe60fa2
	mchs_download "https://docbook.org/xml/4.3/docbook-xml-4.3.zip" \
		$MCHS_PKG_CACHEDIR/docbook-xml-4.3.zip \
		23068a94ea6fd484b004c5a73ec36a66aa47ea8f0d6b62cc1695931f5c143464
	mchs_download "https://docbook.org/xml/4.4/docbook-xml-4.4.zip" \
		$MCHS_PKG_CACHEDIR/docbook-xml-4.4.zip \
		02f159eb88c4254d95e831c51c144b1863b216d909b5ff45743a1ce6f5273090
	mchs_download "https://docbook.org/xml/4.5/docbook-xml-4.5.zip" \
		$MCHS_PKG_CACHEDIR/docbook-xml-4.5.zip \
		4e4e037a2b83c98c6c94818390d4bdd3f6e10f6ec62dd79188594e26190dc7b4
	mkdir -p $MCHS_PKG_SRCDIR
}

mchs_step_post_get_source() {
	cd $MCHS_PKG_SRCDIR
	unzip -d docbook-xml-4.1.2 $MCHS_PKG_CACHEDIR/docbkx412.zip

	local ver
	for ver in 4.{2..5}; do
		unzip -d docbook-xml-${ver} $MCHS_PKG_CACHEDIR/docbook-xml-${ver}.zip
	done
}

mchs_step_make_install() {
	mkdir -p $MCHS_PREFIX/etc/xml
	xmlcatalog --noout --create "$MCHS_PREFIX/etc/xml/docbook-xml"

	local ver
	for ver in 4.1.2 4.{2..5}; do
		pushd docbook-xml-$ver
		mkdir -p "$MCHS_PREFIX/share/xml/docbook/xml-dtd-$ver"
		cp -dr docbook.cat *.dtd ent/ *.mod \
			"$MCHS_PREFIX/share/xml/docbook/xml-dtd-$ver"
		popd

		xml=
		case $ver in
			4.1.2) xml=' XML' ;;&
			*)
				xmlcatalog --noout --add "public" \
					"-//OASIS//DTD DocBook XML V$ver//EN" \
					"http://www.oasis-open.org/docbook/xml/$ver/docbookx.dtd" \
					"$MCHS_PREFIX/etc/xml/docbook-xml"
				xmlcatalog --noout --add "public" \
					"-//OASIS//DTD DocBook$xml CALS Table Model V$ver//EN" \
					"http://www.oasis-open.org/docbook/xml/$ver/calstblx.dtd" \
					"$MCHS_PREFIX/etc/xml/docbook-xml"
				xmlcatalog --noout --add "public" \
					"-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
					"http://www.oasis-open.org/docbook/xml/$ver/soextblx.dtd" \
					"$MCHS_PREFIX/etc/xml/docbook-xml"
				xmlcatalog --noout --add "public" \
					"-//OASIS//ELEMENTS DocBook$xml Information Pool V$ver//EN" \
					"http://www.oasis-open.org/docbook/xml/$ver/dbpoolx.mod" \
					"$MCHS_PREFIX/etc/xml/docbook-xml"
				xmlcatalog --noout --add "public" \
					"-//OASIS//ELEMENTS DocBook$xml Document Hierarchy V$ver//EN" \
					"http://www.oasis-open.org/docbook/xml/$ver/dbhierx.mod" \
					"$MCHS_PREFIX/etc/xml/docbook-xml"
				xmlcatalog --noout --add "public" \
					"-//OASIS//ENTITIES DocBook$xml Additional General Entities V$ver//EN" \
					"http://www.oasis-open.org/docbook/xml/$ver/dbgenent.mod" \
					"$MCHS_PREFIX/etc/xml/docbook-xml"
				xmlcatalog --noout --add "public" \
					"-//OASIS//ENTITIES DocBook$xml Notations V$ver//EN" \
					"http://www.oasis-open.org/docbook/xml/$ver/dbnotnx.mod" \
					"$MCHS_PREFIX/etc/xml/docbook-xml"
				xmlcatalog --noout --add "public" \
					"-//OASIS//ENTITIES DocBook$xml Character Entities V$ver//EN" \
					"http://www.oasis-open.org/docbook/xml/$ver/dbcentx.mod" \
					"$MCHS_PREFIX/etc/xml/docbook-xml"
			;;&
			4.[45])
				xmlcatalog --noout --add "public" \
					"-//OASIS//ELEMENTS DocBook XML HTML Tables V$ver//EN" \
					"http://www.oasis-open.org/docbook/xml/$ver/htmltblx.mod" \
					"$MCHS_PREFIX/etc/xml/docbook-xml"
			;;&
			*)
				xmlcatalog --noout --add "rewriteSystem" \
					"http://www.oasis-open.org/docbook/xml/$ver" \
					"$MCHS_PREFIX/share/xml/docbook/xml-dtd-$ver" \
					"$MCHS_PREFIX/etc/xml/docbook-xml"
				xmlcatalog --noout --add "rewriteURI" \
					"http://www.oasis-open.org/docbook/xml/$ver" \
					"$MCHS_PREFIX/share/xml/docbook/xml-dtd-$ver" \
					"$MCHS_PREFIX/etc/xml/docbook-xml"
			;;&
		esac
	done
}

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ]; then
		if [ ! -e "$MCHS_PREFIX/etc/xml/catalog" ]; then
			xmlcatalog --noout --create "$MCHS_PREFIX/etc/xml/catalog"
		else
			xmlcatalog --noout --del "file://$MCHS_PREFIX/etc/xml/docbook-xml" \
				$MCHS_PREFIX/etc/xml/catalog
		fi
		xmlcatalog --noout --add "delegatePublic" \
			"-//OASIS//ENTITIES DocBook XML" \
			"file://$MCHS_PREFIX/etc/xml/docbook-xml" \
			$MCHS_PREFIX/etc/xml/catalog
		xmlcatalog --noout --add "delegatePublic" \
			"-//OASIS//DTD DocBook XML" \
			"file://$MCHS_PREFIX/etc/xml/docbook-xml" \
			$MCHS_PREFIX/etc/xml/catalog
		xmlcatalog --noout --add "delegateSystem" \
			"http://www.oasis-open.org/docbook/" \
			"file://$MCHS_PREFIX/etc/xml/docbook-xml" \
			$MCHS_PREFIX/etc/xml/catalog
		xmlcatalog --noout --add "delegateURI" \
			"http://www.oasis-open.org/docbook/" \
			"file://$MCHS_PREFIX/etc/xml/docbook-xml" \
			$MCHS_PREFIX/etc/xml/catalog
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "remove" ]; then
		xmlcatalog --noout --del "file://$MCHS_PREFIX/etc/xml/docbook-xml" \
			$MCHS_PREFIX/etc/xml/catalog
	fi
	EOF
}

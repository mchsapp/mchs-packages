MCHS_PKG_HOMEPAGE=https://librdf.org/raptor/
MCHS_PKG_DESCRIPTION="RDF Syntax Library"
MCHS_PKG_LICENSE="LGPL-2.1, GPL-2.0, Apache-2.0"
MCHS_PKG_LICENSE_FILE="COPYING, COPYING.LIB, LICENSE-2.0.txt, LICENSE.txt, NOTICE"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.0.15
MCHS_PKG_SRCURL=https://download.librdf.org/source/raptor2-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ada7f0ba54787b33485d090d3d2680533520cd4426d2f7fb4782dd4a6a1480ed
MCHS_PKG_DEPENDS="libcurl, libicu, libxml2, libxslt, yajl"
MCHS_PKG_BUILD_DEPENDS="icu-devtools"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--with-icu-config=icu-config
--with-yajl=$MCHS_PREFIX
"

mchs_step_pre_configure() {
	local bin="$MCHS_PKG_BUILDDIR/bin"
	local sh="$(command -v sh)"
	mkdir -p "$bin"
	for p in curl icu xml2 xslt; do
		local conf="$bin/${p}-config"
		cat > "$conf" <<-EOF
			#!${sh}
			exec sh "$MCHS_PREFIX/bin/${p}-config" "\$@"
		EOF
		chmod 0700 "$conf"
	done
	export PATH="$bin":$PATH
}

MCHS_PKG_HOMEPAGE=http://biblatex-biber.sourceforge.net
MCHS_PKG_DESCRIPTION="A Unicode-capable BibTeX replacement for biblatex users"
MCHS_PKG_LICENSE="Artistic-License-2.0"
MCHS_PKG_MAINTAINER="Henrik Grimler @Grimler91"
MCHS_PKG_VERSION=2.16
MCHS_PKG_REVISION=2
MCHS_PKG_SKIP_SRC_EXTRACT=true
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_DEPENDS="perl, libxslt, libxml2 (>> 2.9.10-3), openssl-tool, make, clang, pkg-config"

EXTUTILS_LIBBUILDER_VERSION=0.08
TEXT_BIBTEX_VERSION=0.88

mchs_step_make_install() {
	mkdir -p $MCHS_PREFIX/opt/biber
	sed -e "s|@MCHS_PREFIX@|${MCHS_PREFIX}|g" \
		-e "s|@TEXT_BIBTEX_VERSION@|${TEXT_BIBTEX_VERSION}|g" \
		-e "s|@EXTUTILS_LIBBUILDER_VERSION@|${EXTUTILS_LIBBUILDER_VERSION}|g" \
		-e "s|@BIBER_VERSION@|${MCHS_PKG_VERSION}|g" \
		"$MCHS_PKG_BUILDER_DIR"/installer.sh \
		> $MCHS_PREFIX/bin/mchs-install-biber
	chmod 700 $MCHS_PREFIX/bin/mchs-install-biber
	install -m600 "$MCHS_PKG_BUILDER_DIR"/ExtUtils-LibBuilder.diff $MCHS_PREFIX/opt/biber/
	install -m600 "$MCHS_PKG_BUILDER_DIR"/Text-BibTeX.diff $MCHS_PREFIX/opt/biber/
	# Uninstalling all dependencies on uninstall would be annoying, so
	# lets leave that for the user to deal with..
}

mchs_step_create_debscripts() {
	{
		echo "#!$MCHS_PREFIX/bin/sh"
		echo "echo ''"
		echo "echo '[*] You can now run the biber installer by running'"
		echo "echo ''"
		echo "echo '      mchs-install-biber'"
		echo "echo ''"
		echo "echo '    The installation will take a while.'"
	} > ./postinst
}

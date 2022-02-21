MCHS_PKG_HOMEPAGE=https://www.tug.org/texlive/
MCHS_PKG_DESCRIPTION="Wrapper around texlive's install-tl script"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="Henrik Grimler @Grimler91"
MCHS_PKG_VERSION=20210325
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=ftp://ftp.tug.org/texlive/historic/${MCHS_PKG_VERSION:0:4}/install-tl-unx.tar.gz
MCHS_PKG_SHA256=74eac0855e1e40c8db4f28b24ef354bd7263c1f76031bdc02b52156b572b7a1d
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_DEPENDS="perl, texlive-bin (>= 20200406-4), gnupg, curl, lz4, xz-utils"
MCHS_PKG_REPLACES="texlive"
MCHS_PKG_BREAKS="texlive"
MCHS_PKG_RM_AFTER_INSTALL="opt/texlive/install-tl/texmf-dist"

mchs_step_make_install() {
	mkdir -p $MCHS_PREFIX/opt/texlive
	sed -e "s|@MCHS_PREFIX@|${MCHS_PREFIX}|g" \
		-e "s|@INSTALLER_VERSION@|${MCHS_PKG_VERSION}|g" \
		"$MCHS_PKG_BUILDER_DIR"/installer.sh \
		> $MCHS_PREFIX/bin/mchs-install-tl
	chmod 700 $MCHS_PREFIX/bin/mchs-install-tl

	sed -e "s|@MCHS_PREFIX@|${MCHS_PREFIX}|g" \
		"$MCHS_PKG_BUILDER_DIR"/mchs-patch-texlive.sh \
		> $MCHS_PREFIX/bin/mchs-patch-texlive
	chmod 700 $MCHS_PREFIX/bin/mchs-patch-texlive

	sed -e "s|@MCHS_PREFIX@|${MCHS_PREFIX}|g" \
		-e "s|@YEAR@|${MCHS_PKG_VERSION:0:4}|g" \
		"$MCHS_PKG_BUILDER_DIR"/mchs.profile \
		> $MCHS_PREFIX/opt/texlive/mchs.profile
	chmod 600 $MCHS_PREFIX/opt/texlive/mchs.profile

	for DIFF in "$MCHS_PKG_BUILDER_DIR"/*.diff; do
		sed -e "s|@MCHS_PREFIX@|${MCHS_PREFIX}|g" $DIFF \
			> $MCHS_PREFIX/opt/texlive/$(basename $DIFF)
		chmod 600 $MCHS_PREFIX/opt/texlive/$(basename $DIFF)
	done

	if [ -d "$MCHS_PREFIX/opt/texlive/install-tl" ]; then
		rm -r "$MCHS_PREFIX/opt/texlive/install-tl"
	fi
	cp -r $MCHS_PKG_SRCDIR/ $MCHS_PREFIX/opt/texlive/install-tl

	mkdir -p $MCHS_PREFIX/etc/profile.d/
	echo "export PATH=\$PATH:$MCHS_PREFIX/bin/texlive" \
		> $MCHS_PREFIX/etc/profile.d/texlive.sh
}

mchs_step_create_debscripts() {
	{
		echo "#!$MCHS_PREFIX/bin/sh"
		echo "echo ''"
		echo "echo '[*] You can now run the texlive installer by running'"
		echo "echo ''"
		echo "echo '      mchs-install-tl'"
		echo "echo ''"
		echo "echo '    It forwards extra arguments to the install-tl script.'"
	} > ./postinst
}

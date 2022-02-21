MCHS_PKG_HOMEPAGE=https://launchpad.net/pastebinit
MCHS_PKG_DESCRIPTION="Command-line pastebin client"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.5.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/felixonmars/pastebinit/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=30850b9dc6b3e9105321cee159d491891b3d3c03180440edffa296c7e1ac0c41
MCHS_PKG_DEPENDS="python"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi
}

mchs_step_make_install() {
	cp pastebinit $MCHS_PREFIX/bin/
	xsltproc -''-nonet /usr/share/sgml/docbook/stylesheet/xsl/nwalsh/manpages/docbook.xsl pastebinit.xml
	cp pastebinit.1 $MCHS_PREFIX/share/man/man1/

	rm -Rf $MCHS_PREFIX/etc/pastebin.d
	mv pastebin.d $MCHS_PREFIX/etc
}

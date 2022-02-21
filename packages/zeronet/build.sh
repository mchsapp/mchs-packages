MCHS_PKG_HOMEPAGE=https://zeronet.io/
MCHS_PKG_DESCRIPTION="Decentralized websites using Bitcoin crypto and BitTorrent network"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.7.1
MCHS_PKG_REVISION=8
MCHS_PKG_SRCURL=https://github.com/HelloZeroNet/ZeroNet/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=78a27e1687d8e3699a854b77b516c95b30a8ba667f7ebbef0aabf7ec6ec7272d
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_CONFFILES="etc/zeronet.conf"
MCHS_PKG_DEPENDS="bash, clang, make, openssl-tool, pkg-config, python"
MCHS_PKG_RECOMMENDS="tor"

mchs_step_make_install() {
	# ZeroNet sources.
	mkdir -p "$MCHS_PREFIX"/opt
	rm -rf "$MCHS_PREFIX"/opt/zeronet
	cp -a "$MCHS_PKG_SRCDIR" "$MCHS_PREFIX"/opt/zeronet

	# Installer.
	install -Dm700 "$MCHS_PKG_BUILDER_DIR"/installer.sh \
		"$MCHS_PREFIX"/opt/zeronet/installer.sh
	sed -i "s%\@MCHS_PREFIX\@%${MCHS_PREFIX}%g" \
		"$MCHS_PREFIX"/opt/zeronet/installer.sh

	# Wrapper.
	install -Dm700 "$MCHS_PKG_BUILDER_DIR"/zeronet.sh \
		"$MCHS_PREFIX"/bin/zeronet
	sed -i "s%\@MCHS_PREFIX\@%${MCHS_PREFIX}%g" \
		"$MCHS_PREFIX"/bin/zeronet

	# Configuration file.
	install -Dm600 "$MCHS_PKG_BUILDER_DIR"/zeronet.conf \
		"$MCHS_PREFIX"/etc/zeronet.conf
}

mchs_step_post_massage() {
	mkdir -p "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX"/var/lib/zeronet
	mkdir -p "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX"/var/log/zeronet
}

mchs_step_create_debscripts() {
	{
		echo "#!$MCHS_PREFIX/bin/sh"
		echo "bash $MCHS_PREFIX/opt/zeronet/installer.sh"
	} > ./postinst
	chmod 755 ./postinst

	{
		echo "#!$MCHS_PREFIX/bin/sh"
		echo "[ \$1 != remove ] && exit 0"
		echo "echo \"Removing ZeroNet files...\""
		echo "rm -rf $MCHS_PREFIX/opt/zeronet"
		echo "rm -rf $MCHS_PREFIX/var/lib/zeronet"
		echo "rm -rf $MCHS_PREFIX/var/log/zeronet"
		echo "exit 0"
	} > ./postrm
	chmod 755 ./postrm
}

MCHS_PKG_HOMEPAGE=https://nzbget.net/
MCHS_PKG_DESCRIPTION="The most efficient usenet downloader"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=21.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/nzbget/nzbget/releases/download/v${MCHS_PKG_VERSION}/nzbget-${MCHS_PKG_VERSION}-src.tar.gz
MCHS_PKG_SHA256=4e8fc1beb80dc2af2d6a36a33a33f44dedddd4486002c644f4c4793043072025
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libc++, libxml2, ncurses, openssl, p7zip, zlib"
MCHS_PKG_RECOMMENDS="unrar"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_create_debscripts() {
	echo "#!$MCHS_PREFIX/bin/sh" > postinst
	echo "if [ -z \"\$2\" ]; then" >> postinst # Run only on fresh install, not on upgrade
	echo "sed -e 's|^\(CertStore=\).*|\1$MCHS_PREFIX/etc/tls/cert.pem|g" >> postinst
	echo "s|^\(ControlPassword=\).*|\1|g' $MCHS_PREFIX/share/nzbget/nzbget.conf > $MCHS_PREFIX/etc/nzbget.conf" >> postinst
	echo "fi" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}

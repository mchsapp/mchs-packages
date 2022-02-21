MCHS_PKG_HOMEPAGE=https://github.com/azatoth/minidlna
MCHS_PKG_DESCRIPTION="A server software with the aim of being fully compliant with DLNA/UPnP-AV clients"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=http://deb.debian.org/debian/pool/main/m/minidlna/minidlna_${MCHS_PKG_VERSION}+dfsg.orig.tar.xz
MCHS_PKG_SHA256=0b536ff6c689973781f23fb9f9decb7f5ab902b39d57e1991789574de8d5ea5c
MCHS_PKG_DEPENDS="ffmpeg, libexif, libflac, libid3tag, libjpeg-turbo, libsqlite, libvorbis"
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_CONFFILES="etc/minidlna.conf"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--with-log-path=$MCHS_PREFIX/var/log
--with-db-path=$MCHS_PREFIX/var/cache/minidlna
"

mchs_step_pre_configure() {
	./autogen.sh
}

mchs_step_post_make_install() {
	install -Dm600 -t $MCHS_PREFIX/etc minidlna.conf
}

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$MCHS_PREFIX/bin/sh
	mkdir -p $MCHS_PREFIX/var/cache/minidlna
	EOF

	cat <<- EOF > ./prerm
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" != "pacman" ] && [ "\$1" != "remove" ]; then
	exit 0
	fi
	rm -rf $MCHS_PREFIX/var/cache/minidlna
	EOF
}

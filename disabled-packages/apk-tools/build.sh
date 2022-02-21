##
## Since McHs is continuing to use APT as package manager, abuild & apk-tools
## are disabled because don't have real use-cases currently.
##

MCHS_PKG_HOMEPAGE=https://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management
MCHS_PKG_DESCRIPTION="Alpine Linux package management tools"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_VERSION=2.10.4
MCHS_PKG_SRCURL=https://github.com/alpinelinux/apk-tools/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=c08aa725a0437a6a83c5364a1a3a468e4aef5d1d09523369074779021397281c
MCHS_PKG_DEPENDS="openssl, zlib"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_MAKE_ARGS="LUAAPK="
MCHS_PKG_CONFFILES="etc/apk/repositories"

mchs_step_post_make_install() {
    mkdir -p $MCHS_PREFIX/etc/apk/
    echo $MCHS_ARCH > $MCHS_PREFIX/etc/apk/arch

    echo "https://mchs.net/apk/main" > $MCHS_PREFIX/etc/apk/repositories
}

mchs_step_post_massage() {
    mkdir -p "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/etc/apk/keys"
    mkdir -p "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/etc/apk/protected_paths.d"
    mkdir -p "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/lib/apk/db/"
    mkdir -p "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/var/cache/apk"

    ln -sfr \
	"$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/var/cache/apk" \
	"$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/etc/apk/cache"
}

mchs_step_create_debscripts() {
    {
	echo "#!$MCHS_PREFIX/bin/sh"
	echo "touch $MCHS_PREFIX/etc/apk/world"
    } > ./postinst
    chmod 755 postinst
}

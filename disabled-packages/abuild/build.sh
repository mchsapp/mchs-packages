##
## Since McHs is continuing to use APT as package manager, abuild & apk-tools
## are disabled because don't have real use-cases currently.
##

## TODO: restore fakeroot functionality
MCHS_PKG_HOMEPAGE=https://github.com/alpinelinux/abuild
MCHS_PKG_DESCRIPTION="Build script to build Alpine packages"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_VERSION=3.4.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/alpinelinux/abuild/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=f6f704e34f9d388a0228b645050dc7db7bf92f15a088835ae2c9b244420b9b61
MCHS_PKG_DEPENDS="apk-tools, autoconf, automake, bash, clang, curl, libtool, make, openssl-tool, pkg-config, tar, zlib"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_MAKE_ARGS="sysconfdir=$MCHS_PREFIX/etc"
MCHS_PKG_CONFFILES="etc/abuild.conf"

MCHS_PKG_RM_AFTER_INSTALL="
bin/abuild-adduser
bin/abuild-addgroup
bin/abuild-apk
bin/abuild-sudo
bin/buildlab
"

mchs_step_post_make_install() {
    install -Dm600 "$MCHS_PKG_SRCDIR/abuild.conf" "$MCHS_PREFIX/etc/abuild.conf"
}

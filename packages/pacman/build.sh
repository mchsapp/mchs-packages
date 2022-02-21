MCHS_PKG_HOMEPAGE=https://archlinux.org/pacman/
MCHS_PKG_DESCRIPTION="A library-based package manager with dependency support"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@Maxython"
MCHS_PKG_VERSION=6.0.1
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://sources.archlinux.org/other/pacman/pacman-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=0db61456e56aa49e260e891c0b025be210319e62b15521f29d3e93b00d3bf731
MCHS_PKG_DEPENDS="bash, libarchive, curl, gpgme"
MCHS_PKG_BUILD_DEPENDS="doxygen, asciidoc, nettle"
MCHS_PKG_GROUPS="base-devel"
MCHS_PKG_CONFFILES="etc/pacman.conf etc/makepkg.conf"

# A temporary solution to the problem with compiling the documentation.
# https://github.com/mchs/mchs-packages/pull/7759#issuecomment-945664581
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-Ddoc=disabled
"

mchs_step_pre_configure() {
	rm -f ./scripts/libmakepkg/executable/sudo.sh.in
	rm -f ./scripts/libmakepkg/executable/fakeroot.sh.in

	sed -i "s/Architecture = auto/Architecture = ${MCHS_ARCH}/" ./etc/pacman.conf.in
}

mchs_step_post_configure() {
	sed -i 's/$ARGS -o $out $in $LINK_ARGS/$ARGS -o $out $in $LINK_ARGS -landroid-glob/' ${MCHS_TOPDIR}/pacman/build/build.ninja
}

mchs_step_create_debscripts() {
	echo "#!$MCHS_PREFIX/bin/bash" > postinst
	echo "mkdir -p $MCHS_PREFIX/var/lib/pacman/sync" >> postinst
	echo "mkdir -p $MCHS_PREFIX/var/lib/pacman/local" >> postinst
	echo "mkdir -p $MCHS_PREFIX/var/cache/pacman/pkg" >> postinst
	chmod 755 postinst
}

MCHS_PKG_HOMEPAGE=http://e2fsprogs.sourceforge.net
MCHS_PKG_DESCRIPTION="EXT 2/3/4 filesystem utilities"
MCHS_PKG_LICENSE="GPL-2.0, LGPL-2.0, MIT"
MCHS_PKG_LICENSE_FILE="NOTICE"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.46.4
MCHS_PKG_SRCURL=https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v$MCHS_PKG_VERSION/e2fsprogs-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=b11042533c1b1dcf17512f0da48e05b0c573dada1dd8b762864d10f4dc399713
MCHS_PKG_CONFFILES="etc/mke2fs.conf"
MCHS_PKG_NO_STATICSPLIT=true

## util-linux provides libblkid
MCHS_PKG_DEPENDS="libuuid, util-linux"
MCHS_PKG_BREAKS="e2fsprogs-dev"
MCHS_PKG_REPLACES="e2fsprogs-dev"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--sbindir=${MCHS_PREFIX}/bin
--enable-symlink-install
--enable-relative-symlinks
--disable-defrag
--disable-e2initrd-helper
--disable-libuuid
--disable-libblkid
--disable-uuidd
--with-crond_dir=${MCHS_PREFIX}/etc/cron.d"

# Remove com_err.h to avoid conflicting with krb5-dev:
MCHS_PKG_RM_AFTER_INSTALL="
bin/compile_et
bin/e2scrub
bin/e2scrub_all
bin/mk_cmds
etc/cron.d
etc/e2scrub.conf
include/com_err.h
lib/e2fsprogs
share/et
share/ss
share/man/man1/compile_et.1
share/man/man1/mk_cmds.1
share/man/man8/e2scrub.8.gz
share/man/man8/e2scrub_all.8.gz"

mchs_step_make_install() {
	make install install-libs
	install -Dm600 \
		"$MCHS_PKG_SRCDIR"/misc/mke2fs.conf.in \
		"$MCHS_PREFIX"/etc/mke2fs.conf
}

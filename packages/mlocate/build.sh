MCHS_PKG_HOMEPAGE=https://pagure.io/mlocate
MCHS_PKG_DESCRIPTION="Tool to find files anywhere in the filesystem based on their name"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
# If not linking to libandroid-support we segfault in
# the libc mbsnrtowcs() function when using a wildcard
# like in '*.deb'.
MCHS_PKG_DEPENDS="libandroid-support"
MCHS_PKG_VERSION=0.26
MCHS_PKG_REVISION=5
MCHS_PKG_SRCURL=https://releases.pagure.org/mlocate/mlocate-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=3063df79fe198fb9618e180c54baf3105b33d88fe602ff2d8570aaf944f1263e

mchs_step_pre_configure() {
	CPPFLAGS+=" -DLINE_MAX=_POSIX2_LINE_MAX"
}

mchs_step_create_debscripts() {
	echo "#!$MCHS_PREFIX/bin/sh" > postinst
	echo "mkdir -p $MCHS_PREFIX/var/mlocate/" >> postinst
	echo "if [ ! -e $MCHS_PREFIX/var/mlocate/mlocate.db ]; then" >> postinst
	echo "  echo Remember to run \\\`updatedb\\'." >> postinst
	echo "fi" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}

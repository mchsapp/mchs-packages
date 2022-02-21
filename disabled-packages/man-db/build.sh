MCHS_PKG_HOMEPAGE=http://www.nongnu.org/man-db/
MCHS_PKG_DESCRIPTION="Utilities for examining on-line help files (manual pages)"
MCHS_PKG_VERSION=2.7.5
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=http://mirror.csclub.uwaterloo.ca/nongnu/man-db/man-db-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-db=gdbm --with-pager=less --with-config-file=${MCHS_PREFIX}/etc/man_db.conf --disable-setuid --with-browser=lynx --with-gzip=gzip --with-systemdtmpfilesdir=${MCHS_PREFIX}/lib/tmpfiles.d"
MCHS_PKG_DEPENDS="flex, gdbm, groff, less, libandroid-support, libpipeline, lynx"

export GROFF_TMAC_PATH="${MCHS_PREFIX}/lib/groff/site-tmac:${MCHS_PREFIX}/share/groff/site-tmac:${MCHS_PREFIX}/share/groff/current/tmac"

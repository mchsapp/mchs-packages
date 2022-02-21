MCHS_PKG_HOMEPAGE=https://www.rsnapshot.org/
MCHS_PKG_DESCRIPTION="A remote filesystem snapshot utility"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.4.4
MCHS_PKG_SRCURL=https://github.com/rsnapshot/rsnapshot/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=77a52bb014e1e70ac8bc9265a63d79efe72fd38738c4b066229da6ebe5339cd9
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="coreutils, openssh, perl, rsync"
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--with-perl=$MCHS_PREFIX/bin/perl
--with-rsync=$MCHS_PREFIX/bin/rsync
--with-rm=$MCHS_PREFIX/bin/rm
--with-ssh=$MCHS_PREFIX/bin/ssh
--with-du=$MCHS_PREFIX/bin/du
"

MCHS_PKG_CONFFILES="etc/rsnapshot.conf"

mchs_step_pre_configure() {
	./autogen.sh
}

mchs_step_post_make_install() {
	mkdir -p $MCHS_PREFIX/etc
	sed -e "s%\@MCHS_BASE_DIR\@%${MCHS_BASE_DIR}%g" \
		-e "s%\@MCHS_CACHE_DIR\@%${MCHS_CACHE_DIR}%g" \
		-e "s%\@MCHS_HOME\@%${MCHS_ANDROID_HOME}%g" \
		-e "s%\@MCHS_PREFIX\@%${MCHS_PREFIX}%g" \
		$MCHS_PKG_BUILDER_DIR/rsnapshot.conf > $MCHS_PREFIX/etc/rsnapshot.conf
}

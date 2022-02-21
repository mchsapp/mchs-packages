MCHS_PKG_HOMEPAGE=http://www.nongnu.org/nmh/
MCHS_PKG_DESCRIPTION="Powerful electronic mail handling system"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.7.1
MCHS_PKG_REVISION=7
MCHS_PKG_SRCURL=http://download.savannah.nongnu.org/releases/nmh/nmh-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=f1fb94bbf7d95fcd43277c7cfda55633a047187f57afc6c1bb9321852bd07c11
MCHS_PKG_DEPENDS="gdbm, libdb, libiconv, libsasl, openssl"
MCHS_PKG_BUILD_DEPENDS="ncurses"

# We don't have complete sendmail utility.
# Using here a one from busybox, even if it may not work.
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_path_sendmailpath=$MCHS_PREFIX/bin/applets/sendmail
--with-cyrus-sasl
--with-tls"

MCHS_PKG_CONFFILES="
etc/nmh/MailAliases
etc/nmh/components
etc/nmh/digestcomps
etc/nmh/distcomps
etc/nmh/forwcomps
etc/nmh/mhl.body
etc/nmh/mhl.digest
etc/nmh/mhl.format
etc/nmh/mhl.forward
etc/nmh/mhl.headers
etc/nmh/mhl.reply
etc/nmh/mhn.defaults
etc/nmh/mts.conf
etc/nmh/rcvdistcomps
etc/nmh/rcvdistcomps.outbox
etc/nmh/replcomps
etc/nmh/replgroupcomps
etc/nmh/scan.MMDDYY
etc/nmh/scan.YYYYMMDD
etc/nmh/scan.default
etc/nmh/scan.mailx
etc/nmh/scan.nomime
etc/nmh/scan.size
etc/nmh/scan.time
etc/nmh/scan.timely
etc/nmh/scan.unseen"

mchs_step_pre_configure() {
	MCHS_MAKE_PROCESSES=1
	autoreconf -fi
}

mchs_step_post_make_install() {
	# We disabled hardlinks with a patch. Replace them with
	# symlinks here.
	ln -sfr "$MCHS_PREFIX"/bin/flist "$MCHS_PREFIX"/bin/flists
	ln -sfr "$MCHS_PREFIX"/bin/folder "$MCHS_PREFIX"/bin/folders
	ln -sfr "$MCHS_PREFIX"/bin/new "$MCHS_PREFIX"/bin/fnext
	ln -sfr "$MCHS_PREFIX"/bin/new "$MCHS_PREFIX"/bin/fprev
	ln -sfr "$MCHS_PREFIX"/bin/new "$MCHS_PREFIX"/bin/unseen
	ln -sfr "$MCHS_PREFIX"/bin/show "$MCHS_PREFIX"/bin/prev
	ln -sfr "$MCHS_PREFIX"/bin/show "$MCHS_PREFIX"/bin/next
}

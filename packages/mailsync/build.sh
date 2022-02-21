MCHS_PKG_HOMEPAGE=http://mailsync.sourceforge.net/
MCHS_PKG_DESCRIPTION="A way of synchronizing a collection of mailboxes"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.2.7
MCHS_PKG_SRCURL=https://master.dl.sourceforge.net/project/mailsync/mailsync/${MCHS_PKG_VERSION}/mailsync_${MCHS_PKG_VERSION}-1.tar.gz
MCHS_PKG_SHA256=041bff09050d7c57134b53455e9dc7f858c1f8ba968e0cee6c73a226793aa833
MCHS_PKG_DEPENDS="libc++, libc-client"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-c-client=$MCHS_PREFIX"

mchs_step_pre_configure() {
	autoreconf -fi
}

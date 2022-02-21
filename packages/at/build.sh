MCHS_PKG_HOMEPAGE=http://blog.calhariz.com/index.php/tag/at
MCHS_PKG_DESCRIPTION="AT and batch delayed command scheduling utility and daemon"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.2.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://salsa.debian.org/debian/at/-/archive/upstream/${MCHS_PKG_VERSION}/at-upstream-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=8239236f692aba2dba1c5c2cd97ae6aa02bbfe14e23a7e292131b0594a735d84
MCHS_PKG_SUGGESTS="mchs-services"
MCHS_PKG_BUILD_IN_SRC=true

# Force make -j1.
MCHS_MAKE_PROCESSES=1

# Setting loadavg_mx to 8.0 as most devices (8 core)
# do not have loadavg below 5-6.
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_path_SENDMAIL=$MCHS_PREFIX/bin/sendmail
--with-loadavg_mx=8.0
--with-etcdir=$MCHS_PREFIX/etc
--with-jobdir=$MCHS_PREFIX/var/spool/atd
--with-atspool=$MCHS_PREFIX/var/spool/atd
"

# at.allow and at.deny are not supported in McHs.
MCHS_PKG_RM_AFTER_INSTALL="
share/man/man5
"

MCHS_PKG_SERVICE_SCRIPT=("atd" "mkdir -p $MCHS_PREFIX/var/run && exec atd")

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!${MCHS_PREFIX}/bin/sh
	mkdir -p $MCHS_PREFIX/var/run
	EOF
}

MCHS_PKG_HOMEPAGE=https://github.com/cronie-crond/cronie/
MCHS_PKG_DESCRIPTION="Daemon that runs specified programs at scheduled times and related tools"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.5.7
MCHS_PKG_SRCURL=https://github.com/cronie-crond/cronie/releases/download/cronie-${MCHS_PKG_VERSION}/cronie-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=538bcfaf2e986e5ae1edf6d1472a77ea8271d6a9005aee2497a9ed6e13320eb3
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+\.\d+\.\d+"
MCHS_PKG_DEPENDS="dash"
MCHS_PKG_RECOMMENDS="nano"
MCHS_PKG_SUGGESTS="mchs-services"
MCHS_PKG_CONFLICTS="busybox (<< 1.31.1-11)"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-anacron
--disable-pam
--with-editor=$MCHS_PREFIX/bin/nano
"

MCHS_PKG_SERVICE_SCRIPT=("crond" 'exec crond -n -s')

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$MCHS_PREFIX/bin/sh
	mkdir -p $MCHS_PREFIX/var/run
	mkdir -p $MCHS_PREFIX/var/spool/cron
	mkdir -p $MCHS_PREFIX/etc/cron.d
	EOF
}

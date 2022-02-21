MCHS_PKG_HOMEPAGE=https://www.bacula.org
MCHS_PKG_DESCRIPTION="Bacula backup software"
MCHS_PKG_LICENSE="AGPL-V3"
MCHS_PKG_MAINTAINER="Matlink <matlink@matlink.fr>"
MCHS_PKG_VERSION=11.0.5
MCHS_PKG_SRCURL=https://sourceforge.net/projects/bacula/files/bacula/${MCHS_PKG_VERSION}/bacula-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ef5b3b67810442201b80dc1d47ccef77b5ed378fe1285406f3a73401b6e8111a
MCHS_PKG_DEPENDS="openssl"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_CONFFILES=etc/bacula/bacula-fd.conf
MCHS_PKG_SERVICE_SCRIPT=("bacula-fd" "${MCHS_PREFIX}/bin/bacula-fd")
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--sysconfdir=${MCHS_PREFIX}/etc/bacula
--with-plugindir=${MCHS_PREFIX}/lib/bacula
--mandir=${MCHS_PREFIX}/share/man
--with-logdir=${MCHS_PREFIX}/var/log
--with-working-dir=${MCHS_PREFIX}/var/run/bacula
--with-pid-dir=${MCHS_PREFIX}/var/run/bacula
--with-scriptdir=${MCHS_PREFIX}/etc/bacula/scripts
--with-ssl
--enable-smartalloc
--enable-conio
--enable-client-only
--with-baseport=9102
ac_cv_func_setpgrp_void=yes
"

mchs_step_pre_configure() {
	LDFLAGS+=" -Wl,-rpath=${MCHS_PREFIX}/lib/bacula -Wl,--enable-new-dtags"
}

mchs_step_post_massage() {
	mkdir -p ${MCHS_PKG_MASSAGEDIR}${MCHS_PREFIX}/var/run/bacula
}

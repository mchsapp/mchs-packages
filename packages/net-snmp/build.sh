MCHS_PKG_HOMEPAGE=http://www.net-snmp.org/
MCHS_PKG_DESCRIPTION="Various tools relating to the Simple Network Management Protocol"
# Licenses: HPND, BSD 3-Clause, MIT
MCHS_PKG_LICENSE="custom"
MCHS_PKG_LICENSE_FILE="COPYING"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.9.1
MCHS_PKG_SRCURL=https://github.com/net-snmp/net-snmp/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=bdff5fe0915369971e4c7f8e43283fa5fdd08785c7d3b61431465562112d86e7
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--with-agentx-socket=$MCHS_PREFIX/var/agentx/master
--with-default-snmp-version=3
--with-logfile=$MCHS_PREFIX/var/log/net-snmpd.log
--with-mnttab=$MCHS_PREFIX/etc/mtab
--with-persistent-directory=$MCHS_PREFIX/var/lib/net-snmp
--with-sys-contact=root@localhost
--with-sys-location=Unknown
--with-temp-file-pattern=$MCHS_PREFIX/tmp/snmpdXXXXXX
ac_cv_path_LPSTAT_PATH=$MCHS_PREFIX/bin/lpstat
"

mchs_step_pre_configure() {
	if [ $MCHS_ARCH = "x86_64" ]; then
		CPPFLAGS+=" -DOPENSSL_NO_INLINE_ASM"
	fi
}

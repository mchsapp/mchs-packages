MCHS_PKG_HOMEPAGE=http://www.snmptt.org/
MCHS_PKG_DESCRIPTION="SNMP trap translator"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.4.2
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/snmptt/snmptt_${MCHS_PKG_VERSION}.tgz
MCHS_PKG_SHA256=1b455a5ae252dab5d828926125073b5376e36855e38423aca8da9bce6c4920c5
MCHS_PKG_DEPENDS="net-snmp, perl"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	find . -maxdepth 1 -type f -name 'snmptt*' | xargs -n 1 sed -i \
		-e 's:\([^A-Za-z0-9.]\)/etc/:\1'$MCHS_PREFIX'/etc/:g' \
		-e 's:\([^A-Za-z0-9.]\)/sbin/:\1'$MCHS_PREFIX'/bin/:g' \
		-e 's:\([^A-Za-z0-9.]\)/usr/sbin/:\1'$MCHS_PREFIX'/bin/:g' \
		-e 's:\([^A-Za-z0-9.]\)/var/:\1'$MCHS_PREFIX'/var/:g' \
		-e 's:\([^A-Za-z0-9.]\)/usr/local/etc/:\1'$MCHS_PREFIX'/local/etc/:g'
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin \
		snmptt snmptt-net-snmp-test \
		snmpttconvert snmpttconvertmib \
		snmptthandler snmptthandler-embedded
	install -Dm600 -t $MCHS_PREFIX/share/snmptt/examples examples/*
	install -Dm600 -t $MCHS_PREFIX/etc/snmp snmptt.ini
	install -Dm600 -T examples/snmptt.conf.generic \
		$MCHS_PREFIX/etc/snmp/snmptt.conf
}

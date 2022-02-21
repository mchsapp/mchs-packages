MCHS_PKG_HOMEPAGE=https://openldap.org
MCHS_PKG_DESCRIPTION="OpenLDAP server"
MCHS_PKG_LICENSE="OpenLDAP"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.5.4
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-$MCHS_PKG_VERSION.tgz
MCHS_PKG_SHA256=61c03c078d70cd859e504fa9555d7d52426eed4b29e6a39e828afc213e4fb356
MCHS_PKG_DEPENDS="libsasl, libuuid, openssl"
MCHS_PKG_BREAKS="openldap-dev"
MCHS_PKG_REPLACES="openldap-dev"
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ol_cv_lib_icu=no
ac_cv_func_memcmp_working=yes
--enable-dynamic
--with-yielding_select=yes
--enable-backends=no
--enable-monitor
--enable-mdb
--enable-ldap"

mchs_step_pre_configure() {
	CFLAGS+=" -DMDB_USE_ROBUST=0"
	LDFLAGS+=" -lcrypto -llog"
}

mchs_step_make_install() {
	make STRIP="" install

	local slot=${MCHS_PKG_VERSION%.*}
	for lib in lber ldap; do
		local target=lib${lib}-${slot}.so
		if [ -e $MCHS_PREFIX/lib/${target} ]; then
			ln -sf ${target} $MCHS_PREFIX/lib/lib${lib}.so
		fi
	done
}

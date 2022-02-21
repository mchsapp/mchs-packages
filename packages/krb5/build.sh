MCHS_PKG_HOMEPAGE=https://web.mit.edu/kerberos
MCHS_PKG_DESCRIPTION="The Kerberos network authentication system"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_LICENSE_FILE="../NOTICE"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.19.2
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://fossies.org/linux/misc/krb5-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=10453fee4e3a8f8ce6129059e5c050b8a65dab1c257df68b99b3112eaa0cdf6a
MCHS_PKG_DEPENDS="libandroid-support, libandroid-glob, libresolv-wrapper, readline, openssl, libdb"
MCHS_PKG_BREAKS="krb5-dev"
MCHS_PKG_REPLACES="krb5-dev"
MCHS_PKG_CONFFILES="etc/krb5.conf var/krb5kdc/kdc.conf"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--with-readline
--without-system-verto
--enable-dns-for-realm
--sbindir=$MCHS_PREFIX/bin
--with-size-optimizations
--with-system-db
DEFCCNAME=$MCHS_PREFIX/tmp/krb5cc_%{uid}
DEFKTNAME=$MCHS_PREFIX/etc/krb5.keytab
DEFCKTNAME=$MCHS_PREFIX/var/krb5/user/%{euid}/client.keytab
"

mchs_step_post_get_source() {
	MCHS_PKG_SRCDIR+="/src"
}

mchs_step_pre_configure() {
	# cannot test these when cross compiling
	export krb5_cv_attr_constructor_destructor='yes,yes'
	export ac_cv_func_regcomp='yes'
	export ac_cv_printf_positional='yes'

	# bionic doesn't have getpass
	cp "$MCHS_PKG_BUILDER_DIR/netbsd_getpass.c" "$MCHS_PKG_SRCDIR/clients/kpasswd/"

	CFLAGS="$CFLAGS -D_PASSWORD_LEN=PASS_MAX"
	export LIBS="-landroid-glob -lresolv_wrapper"
}

mchs_step_post_make_install() {
	# Enable logging to STDERR by default
	echo -e "\tdefault = STDERR" >> $MCHS_PKG_SRCDIR/config-files/krb5.conf

	# Sample KDC config file
	install -dm 700 $MCHS_PREFIX/var/krb5kdc
	install -pm 600 $MCHS_PKG_SRCDIR/config-files/kdc.conf $MCHS_PREFIX/var/krb5kdc/kdc.conf

	# Default configuration file
	install -pm 600 $MCHS_PKG_SRCDIR/config-files/krb5.conf $MCHS_PREFIX/etc/krb5.conf

	install -dm 700 $MCHS_PREFIX/share/aclocal
	install -m 600 $MCHS_PKG_SRCDIR/util/ac_check_krb5.m4 $MCHS_PREFIX/share/aclocal
}

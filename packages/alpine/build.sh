MCHS_PKG_HOMEPAGE=http://alpine.x10host.com/
MCHS_PKG_DESCRIPTION="Fast, easy to use email client"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.25
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=http://alpine.x10host.com/alpine/release/src/alpine-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=658a150982f6740bb4128e6dd81188eaa1212ca0bf689b83c2093bb518ecf776
MCHS_PKG_DEPENDS="coreutils, libcrypt, ncurses, openssl-tool"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-debug
--with-c-client-target=lnx
--without-krb5
--without-ldap
--without-pthread
--without-tcl
--with-system-pinerc=${MCHS_PREFIX}/etc/pine.conf
--with-passfile=$MCHS_ANDROID_HOME/.pine-passfile
"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	export TCC=$CC
	export TRANLIB=$RANLIB
	export SPELLPROG=${MCHS_PREFIX}/bin/hunspell
	export alpine_SSLVERSION=old
	export TPATH=$PATH

	export LIBS="-lcrypt"

	# To get S_IREAD and friends:
	CPPFLAGS+=" -D__USE_BSD"

	cp $MCHS_PKG_BUILDER_DIR/pine.conf $MCHS_PREFIX/etc/pine.conf

	touch $MCHS_PKG_SRCDIR/imap/lnxok
}

mchs_step_post_configure() {
	cd pith
	$CC_FOR_BUILD help_c_gen.c -o help_c_gen
	$CC_FOR_BUILD help_h_gen.c -o help_h_gen
	touch -d "next hour" help_c_gen help_h_gen
}
mchs_step_create_debscripts() {

	echo "#!$MCHS_PREFIX/bin/sh" >> postinst
	echo "if [ ! -e $MCHS_ANDROID_HOME/.alpine-smime/.pwd/MasterPassword.crt ] && [ ! -e $HOME/.alpine-smime/.pwd/MasterPassword.key ]; then" >> postinst
	echo "echo 'warning making a passwordless masterpasword file'" >> postinst
	echo "mkdir -p \$HOME/.alpine-smime/public \$HOME/.alpine-smime/.pwd \$HOME/.alpine-smime/private \$HOME/.alpine-smime/ca" >> postinst
	echo "openssl req -x509 -newkey rsa:2048 -keyout \$HOME/.alpine-smime/.pwd/MasterPassword.key -out \$HOME/.alpine-smime/.pwd/MasterPassword.crt -days 10000 -nodes -subj '/C=US/ST=dont/L=use/O=this Name/OU=for/CN=anything.com.mchs'" >> postinst
	echo "touch \$HOME/.pine-passfile" >> postinst
	echo "fi" >> postinst
}


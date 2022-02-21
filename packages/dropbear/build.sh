MCHS_PKG_HOMEPAGE=https://matt.ucc.asn.au/dropbear/dropbear.html
MCHS_PKG_DESCRIPTION="Small SSH server and client"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2020.81
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://matt.ucc.asn.au/dropbear/releases/dropbear-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=48235d10b37775dbda59341ac0c4b239b82ad6318c31568b985730c788aac53b
MCHS_PKG_DEPENDS="mchs-auth, zlib"
MCHS_PKG_CONFLICTS="openssh"
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-syslog --disable-utmp --disable-utmpx --disable-wtmp --disable-static"
# Avoid linking to libcrypt for server password authentication:
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_lib_crypt_crypt=no"
# build a multi-call binary & enable progress info in 'scp'
MCHS_PKG_EXTRA_MAKE_ARGS="MULTI=1 SCPPROGRESS=1"

mchs_step_pre_configure() {
	export LIBS="-lmchs-auth"
}

mchs_step_post_make_install() {
	ln -sf "dropbearmulti" "${MCHS_PREFIX}/bin/ssh"
}

mchs_step_create_debscripts() {
	{
	echo "#!$MCHS_PREFIX/bin/sh"
	echo "mkdir -p $MCHS_PREFIX/etc/dropbear"
	echo "for a in rsa dss ecdsa; do"
	echo "	KEYFILE=$MCHS_PREFIX/etc/dropbear/dropbear_\${a}_host_key"
	echo "	test ! -f \$KEYFILE && dropbearkey -t \$a -f \$KEYFILE"
	echo "done"
	echo "exit 0"
	} > postinst
	chmod 0755 postinst
}

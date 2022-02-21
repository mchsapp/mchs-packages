MCHS_PKG_HOMEPAGE=https://packages.debian.org/sid/netcat-openbsd
MCHS_PKG_DESCRIPTION="TCP/IP swiss army knife. OpenBSD variant."
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.217-2
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://salsa.debian.org/debian/netcat-openbsd/-/archive/debian/${MCHS_PKG_VERSION}/netcat-openbsd-debian-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=bb6427c49015c8d485c013898b08808192bf5719c40a79676162e5c2d971a34e
MCHS_PKG_DEPENDS="libbsd"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	local p
	for p in $(cat debian/patches/series); do
		echo "Applying debian/patches/$p"
		patch -p1 -i debian/patches/$p
	done

	sed -i -e 's@-lresolv@@g' \
		-e 's@CFLAGS=@CFLAGS?=@g' \
		Makefile

	CFLAGS+=" $CPPFLAGS $LDFLAGS"
}

mchs_step_make_install() {
	install -Dm700 nc $MCHS_PREFIX/bin/netcat-openbsd
	ln -sfr $MCHS_PREFIX/bin/netcat-openbsd $MCHS_PREFIX/bin/netcat
	ln -sfr $MCHS_PREFIX/bin/netcat-openbsd $MCHS_PREFIX/bin/nc
	install -Dm600 nc.1 $MCHS_PREFIX/share/man/man1/netcat-openbsd.1
	ln -sfr $MCHS_PREFIX/share/man/man1/netcat-openbsd.1 \
		$MCHS_PREFIX/share/man/man1/netcat.1
	ln -sfr $MCHS_PREFIX/share/man/man1/netcat-openbsd.1 \
		$MCHS_PREFIX/share/man/man1/nc.1
}

mchs_step_install_license() {
	mkdir -p $MCHS_PREFIX/share/doc/netcat-openbsd
	head -n28 netcat.c | tail -n+2 > $MCHS_PREFIX/share/doc/netcat-openbsd/LICENSE
}

MCHS_PKG_HOMEPAGE=https://tinyproxy.github.io/
MCHS_PKG_DESCRIPTION="Light-weight HTTP proxy daemon for POSIX operating systems"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.11.0
MCHS_PKG_SRCURL=https://github.com/tinyproxy/tinyproxy/releases/download/${MCHS_PKG_VERSION}/tinyproxy-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=c1ec81cfc4c551d2c24e0227a5aeeaad8723bd9a39b61cd729e516b82eaa3f32
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-regexcheck"

mchs_step_post_massage() {
	mkdir -p $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/var/log/$MCHS_PKG_NAME
	mkdir -p $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/var/run/$MCHS_PKG_NAME
	find $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/var -exec chmod -f u+w,g-rwx,o-rwx \{\} \;
}

mchs_step_pre_configure() {
	CPPFLAGS+=" -DLINE_MAX=_POSIX2_LINE_MAX"
}

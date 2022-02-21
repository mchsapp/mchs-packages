MCHS_PKG_HOMEPAGE=https://www.xiph.org/ao/
MCHS_PKG_DESCRIPTION="A cross platform audio library"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.2.2
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/xiph/libao/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=df8a6d0e238feeccb26a783e778716fb41a801536fe7b6fce068e313c0e2bf4d
MCHS_PKG_DEPENDS="pulseaudio"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--enable-pulse"
MCHS_PKG_CONFFILES="etc/libao.conf"

mchs_step_pre_configure () {
	./autogen.sh
}

mchs_step_post_make_install () {
	#generate libao config file
	mkdir -p $MCHS_PREFIX/etc/
	cat << EOF > $MCHS_PREFIX/etc/libao.conf
default_driver=pulse
buffer_time=50
quiet
EOF
}

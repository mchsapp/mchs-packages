MCHS_PKG_HOMEPAGE=http://www.underbit.com/products/mad/
MCHS_PKG_DESCRIPTION="MAD is a high-quality MPEG audio decoder"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.15.1b
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=ftp://ftp.mars.org/pub/mpeg/libmad-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=bbfac3ed6bfbc2823d3775ebb931087371e142bb0e9bb1bee51a76a6e0078690
MCHS_PKG_BREAKS="libmad-dev"
MCHS_PKG_REPLACES="libmad-dev"

mchs_step_pre_configure() {
	if [ $MCHS_ARCH = arm ]; then
		# See https://www.mars.org/pipermail/mad-dev/2013-July/001433.html
		MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-fpm=default"
	fi
}

mchs_post_configure() {
	cd $MCHS_PKG_SRCDIR
	sed -i -e 's/-force-mem//g' Makefile
}

mchs_step_post_make_install() {
	mkdir -p $MCHS_PKG_CONFIG_LIBDIR
	cat > $MCHS_PKG_CONFIG_LIBDIR/mad.pc <<-EOF
		prefix=$MCHS_PREFIX
		exec_prefix=\${prefix}
		libdir=$MCHS_PREFIX/lib
		includedir=\${prefix}/include

		Name: mad
		Description: MPEG Audio Decoder
		Requires:
		Version: $MCHS_PKG_VERSION
		Libs: -L\${libdir} -lmad
		Cflags: -I\${includedir}
	EOF
}

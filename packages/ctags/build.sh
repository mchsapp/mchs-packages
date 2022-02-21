MCHS_PKG_HOMEPAGE=https://ctags.io/
MCHS_PKG_DESCRIPTION="Universal ctags: Source code index builder"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2:5.9.20210613.0
MCHS_PKG_SRCURL=https://github.com/universal-ctags/ctags/archive/p${MCHS_PKG_VERSION:2}.tar.gz
MCHS_PKG_SHA256=74c9e515f0cb71d92b4422392effba21794b11fc34f0971aa4dc44e9a86708f4
MCHS_PKG_DEPENDS="libiconv, libjansson, liblzma, libxml2, libyaml"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--enable-tmpdir=$MCHS_PREFIX/tmp --disable-static"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_HOSTBUILD=true

mchs_step_post_get_source() {
	export regcomp_works=yes
	./autogen.sh
}

mchs_step_pre_configure() {
	./autogen.sh
	cp $MCHS_PKG_HOSTBUILD_DIR/packcc $MCHS_PKG_BUILDDIR/
	touch -d "next hour" $MCHS_PKG_BUILDDIR/packcc
}

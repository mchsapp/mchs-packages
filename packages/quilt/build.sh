MCHS_PKG_HOMEPAGE=https://savannah.nongnu.org/projects/quilt
MCHS_PKG_DESCRIPTION="Allows you to easily manage large numbers of patches"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.66
MCHS_PKG_SRCURL=https://savannah.nongnu.org/download/quilt/quilt-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=314b319a6feb13bf9d0f9ffa7ce6683b06919e734a41275087ea457cc9dc6e07
MCHS_PKG_DEPENDS="coreutils, diffstat, gawk, graphviz, perl"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--with-diffstat=$MCHS_PREFIX/bin/diffstat
--without-7z
--without-rpmbuild
--without-sendmail
"

mchs_step_post_make_install() {
	ln -sf $MCHS_PREFIX/bin/gawk $MCHS_PREFIX/share/quilt/compat/awk
}

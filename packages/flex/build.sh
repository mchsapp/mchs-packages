MCHS_PKG_HOMEPAGE=https://github.com/westes/flex
MCHS_PKG_DESCRIPTION="Fast lexical analyser generator"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.6.4
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/westes/flex/releases/download/v${MCHS_PKG_VERSION}/flex-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=e87aae032bf07c26f85ac0ed3250998c37621d95f8bd748b31f15b33c45ee995
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="m4"
MCHS_PKG_HOSTBUILD=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS+="ac_cv_path_M4=$MCHS_PREFIX/bin/m4"
MCHS_PKG_CONFLICTS="flex-dev"
MCHS_PKG_REPLACES="flex-dev"
MCHS_PKG_GROUPS="base-devel"

# Work around https://github.com/westes/flex/issues/241 when building
# under ubuntu 17.10:
MCHS_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="CFLAGS=-D_GNU_SOURCE=1"

mchs_step_pre_configure() {
	mkdir -p $MCHS_PKG_BUILDDIR/src/
	cp $MCHS_PKG_HOSTBUILD_DIR/src/stage1flex $MCHS_PKG_BUILDDIR/src/stage1flex
	touch -d "next hour" $MCHS_PKG_BUILDDIR/src/stage1flex
}

MCHS_PKG_HOMEPAGE=http://site.icu-project.org/home
MCHS_PKG_DESCRIPTION='International Components for Unicode library'
MCHS_PKG_LICENSE="BSD"
# We override MCHS_PKG_SRCDIR mchs_step_post_get_source so need to do
# this hack to be able to find the license file.
MCHS_PKG_LICENSE_FILE="../LICENSE"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=70.1
MCHS_PKG_SRCURL=https://github.com/unicode-org/icu/releases/download/release-${MCHS_PKG_VERSION//./-}/icu4c-${MCHS_PKG_VERSION//./_}-src.tgz
MCHS_PKG_SHA256=8d205428c17bf13bb535300669ed28b338a157b1c01ae66d31d0d3e2d47c3fd5
MCHS_PKG_DEPENDS="libc++"
MCHS_PKG_BREAKS="libicu-dev"
MCHS_PKG_REPLACES="libicu-dev"
MCHS_PKG_HOSTBUILD=true
MCHS_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="--disable-samples --disable-tests"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-samples --disable-tests --with-cross-build=$MCHS_PKG_HOSTBUILD_DIR"

mchs_step_post_get_source() {
	MCHS_PKG_SRCDIR+="/source"
	find . -type f | xargs touch
}

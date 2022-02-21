MCHS_PKG_HOMEPAGE=https://github.com/MaskRay/ccls
MCHS_PKG_DESCRIPTION="C/C++/ObjC language server"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.20210330
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/MaskRay/ccls/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=28c228f49dfc0f23cb5d581b7de35792648f32c39f4ca35f68ff8c9cb5ce56c2
MCHS_PKG_DEPENDS="libllvm"
MCHS_PKG_BUILD_DEPENDS="rapidjson, libllvm-static"

mchs_step_pre_configure() {
	touch $MCHS_PREFIX/bin/{clang-import-test,clang-offload-wrapper}
}

mchs_step_post_make_install() {
	rm $MCHS_PREFIX/bin/{clang-import-test,clang-offload-wrapper}
}

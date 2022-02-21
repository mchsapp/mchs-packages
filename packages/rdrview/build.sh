MCHS_PKG_HOMEPAGE=https://github.com/eafer/rdrview
MCHS_PKG_DESCRIPTION="Command line tool to extract the main content from a webpage"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=9bde19f9e53562790b363bb2e3b15707c8c67676
MCHS_PKG_VERSION=2021.09.12
MCHS_PKG_SRCURL=https://github.com/eafer/rdrview.git
MCHS_PKG_GIT_BRANCH=master
MCHS_PKG_DEPENDS="libcurl, libiconv, libseccomp, libxml2"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT
}

mchs_step_pre_configure() {
	LDFLAGS+=" -liconv"
}

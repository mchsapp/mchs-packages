MCHS_PKG_HOMEPAGE=https://github.com/krrishnarraj/clpeak
MCHS_PKG_DESCRIPTION="A tool which profiles OpenCL devices to find their peak capacities"
MCHS_PKG_LICENSE="Unlicense"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.1.2
MCHS_PKG_REVISION=1
MCHS_PKG_GIT_BRANCH=$MCHS_PKG_VERSION
MCHS_PKG_SRCURL=https://github.com/krrishnarraj/clpeak.git
MCHS_PKG_BUILD_DEPENDS="opencl-headers, opencl-clhpp"
MCHS_PKG_DEPENDS="libc++, ocl-icd"

mchs_step_post_get_source() {
	git fetch --unshallow
	git submodule deinit --force --all
	git submodule update --init --recursive
}

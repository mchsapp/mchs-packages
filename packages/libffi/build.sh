MCHS_PKG_HOMEPAGE=https://sourceware.org/libffi/
MCHS_PKG_DESCRIPTION="Library providing a portable, high level programming interface to various calling conventions"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.4.2
MCHS_PKG_SRCURL=https://github.com/libffi/libffi/releases/download/v${MCHS_PKG_VERSION}/libffi-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=540fb721619a6aba3bdeef7d940d8e9e0e6d2c193595bc243241b77ff9e93620
MCHS_PKG_BREAKS="libffi-dev"
MCHS_PKG_REPLACES="libffi-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-multi-os-directory"
MCHS_PKG_RM_AFTER_INSTALL="lib/libffi-${MCHS_PKG_VERSION}/include"

mchs_step_pre_configure() {
	if [ $MCHS_ARCH = arm ]; then
		CFLAGS+=" -fno-integrated-as"
	fi
}
mchs_step_post_configure() {
	# work around since mmap can't be written and marked executable in android anymore from userspace
	echo "#define FFI_MMAP_EXEC_WRIT 1" >> fficonfig.h
}

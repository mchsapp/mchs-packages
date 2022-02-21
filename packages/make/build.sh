MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/make/
MCHS_PKG_DESCRIPTION="Tool to control the generation of non-source files from source files"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.3
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/make/make-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=e05fdde47c5f7ca45cb697e973894ff4f5d79e13b750ed57d7b66d8defc78e19
MCHS_PKG_BREAKS="make-dev"
MCHS_PKG_REPLACES="make-dev"
MCHS_PKG_GROUPS="base-devel"
# Prevent linking against libelf:
MCHS_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_elf_elf_begin=no"

mchs_step_pre_configure() {
    if [ "$MCHS_ARCH" = arm ]; then
	# Fix issue with make on arm hanging at least under cmake:
	# https://github.com/mchs/mchs-packages/issues/2983
	MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_pselect=no"
    fi
}

mchs_step_make() {
	# Allow to bootstrap make if building on device without make installed.
	if $MCHS_ON_DEVICE_BUILD && [ -z "$(command -v make)" ]; then
		./build.sh
	else
		make -j $MCHS_MAKE_PROCESSES
	fi
}

mchs_step_make_install() {
	if $MCHS_ON_DEVICE_BUILD && [ -z "$(command -v make)" ]; then
		./make -j 1 install
	else
		make -j 1 install
	fi
}

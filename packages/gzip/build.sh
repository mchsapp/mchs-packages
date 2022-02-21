MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/gzip/
MCHS_PKG_DESCRIPTION="Standard GNU file compression utilities"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.11
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/gzip/gzip-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=9b9a95d68fdcb936849a4d6fada8bf8686cddf58b9b26c9c4289ed0c92a77907
MCHS_PKG_ESSENTIAL=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_path_GREP=grep"
MCHS_PKG_GROUPS="base-devel"

mchs_step_pre_configure() {
	if [ $MCHS_ARCH = i686 ]; then
		# Avoid text relocations
		export DEFS="NO_ASM"
	fi
}

MCHS_PKG_HOMEPAGE=https://github.com/OCL-dev/ocl-icd
MCHS_PKG_DESCRIPTION="OpenCL ICD Loader"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.3.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/OCL-dev/ocl-icd/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=a32b67c2d52ffbaf490be9fc18b46428ab807ab11eff7664d7ff75e06cfafd6d
MCHS_PKG_NO_STATICSPLIT=true
MCHS_PKG_BUILD_DEPENDS="opencl-headers"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--enable-custom-vendordir=$MCHS_PREFIX/etc/OpenCL/vendors
"

# https://www.khronos.org/registry/OpenCL/specs/2.2/html/OpenCL_ICD_Installation.html
# Intepreting this as providing library "libOpenCL.so" with SONAME "libOpenCL.so" on Android

mchs_step_pre_configure() {
	./bootstrap
}

mchs_step_post_make_install() {
	# User is still expected to export LD_LIBRARY_PATH environment variable to use
	# vendor provided libOpenCL.so on Android
	if [ "$MCHS_ARCH_BITS" = 64 ]; then
		echo "/vendor/lib64/libOpenCL.so" > "$MCHS_PKG_TMPDIR/android.icd"
	else
		echo "/vendor/lib/libOpenCL.so" > "$MCHS_PKG_TMPDIR/android.icd"
	fi
	install -Dm644 "$MCHS_PKG_TMPDIR/android.icd" "$MCHS_PREFIX/etc/OpenCL/vendors/android.icd"
}

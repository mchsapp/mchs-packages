MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/coreutils/
MCHS_PKG_DESCRIPTION="Basic file, shell and text manipulation utilities from the GNU project"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=9.0
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/coreutils/coreutils-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=ce30acdf4a41bc5bb30dd955e9eaa75fa216b4e3deb08889ed32433c7b3b97ce
MCHS_PKG_DEPENDS="libandroid-support, libgmp, libiconv"
MCHS_PKG_BREAKS="chroot, busybox (<< 1.30.1-4)"
MCHS_PKG_REPLACES="chroot, busybox (<< 1.30.1-4)"
MCHS_PKG_ESSENTIAL=true

# pinky has no usage on Android.
# df does not work either, let system binary prevail.
# $PREFIX/bin/env is provided by busybox for shebangs to work directly.
# users and who doesn't work and does not make much sense for McHs.
# uptime is provided by procps.
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
gl_cv_host_operating_system=Android
ac_cv_func_getpass=yes
--disable-xattr
--enable-no-install-program=pinky,df,users,who,uptime
--enable-single-binary=symlinks
--with-gmp
"

mchs_step_pre_configure() {
	CPPFLAGS+=" -D__USE_FORTIFY_LEVEL=0"

	# On device build is unsupported as it removes utility 'ln' (and maybe
	# something else) in the installation process.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi
}

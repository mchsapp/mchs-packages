MCHS_PKG_HOMEPAGE=https://www.open-mpi.org
MCHS_PKG_DESCRIPTION="Open source Message Passing Interface implementation"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="Henrik Grimler @Grimler91"
MCHS_PKG_VERSION=4.1.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://download.open-mpi.org/release/open-mpi/v${MCHS_PKG_VERSION:0:3}/openmpi-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=d80b9219e80ea1f8bcfe5ad921bd9014285c4948c5965f4156a3831e60776444
MCHS_PKG_DEPENDS="libandroid-shmem"
MCHS_PKG_BREAKS="openmpi-dev"
MCHS_PKG_REPLACES="openmpi-dev"
MCHS_PKG_GROUPS="science"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--without-x
--disable-dlopen
--disable-mpi-fortran
ac_cv_header_ifaddrs_h=no
ac_cv_member_struct_ifreq_ifr_hwaddr=no
"

mchs_step_pre_configure () {
	# rindex is an obsolete version of strrchr which is not available in Android:
	CFLAGS+=" -Drindex=strrchr -Dbcmp=memcmp"
	LDFLAGS="${LDFLAGS/-Wl,--as-needed/}"
	LDFLAGS+=" -landroid-shmem"
	if [ $MCHS_ARCH == "i686" ]; then
		# fails with "undefined reference to __atomic..."
		LDFLAGS+=" -latomic"
	fi

	./autogen.pl --force
}

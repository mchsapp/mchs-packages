MCHS_PKG_HOMEPAGE=https://www.tianocore.org/
MCHS_PKG_DESCRIPTION="Open Virtual Machine Firmware"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=20211216.122.gc9b7c6e0cc
MCHS_PKG_SRCURL=(https://www.kraxel.org/repos/jenkins/edk2/edk2.git-aarch64-0-${MCHS_PKG_VERSION}.noarch.rpm
		   https://www.kraxel.org/repos/jenkins/edk2/edk2.git-arm-0-${MCHS_PKG_VERSION}.noarch.rpm
		   https://www.kraxel.org/repos/jenkins/edk2/edk2.git-ovmf-ia32-0-${MCHS_PKG_VERSION}.noarch.rpm
		   https://www.kraxel.org/repos/jenkins/edk2/edk2.git-ovmf-x64-0-${MCHS_PKG_VERSION}.noarch.rpm)
MCHS_PKG_SHA256=(569794ea79bf548c9bad55ae278d462c961949ec2d65e3a4720daea94e696263
		   da36eb7073ca3ff0dad4c322d75ce84d4b1bef9f3a5a9a757f999b3c317af53e
		   307ae61dc11b8efb3ae400e72b301bca7b6353fb665e7137f5e70d82ebac5222
		   aef9b4879a4366ca1253514418f755f643ddb8e56b5332dc026da77188afb20a)
MCHS_PKG_SKIP_SRC_EXTRACT=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make_install() {
	mchs_download \
		${MCHS_PKG_SRCURL[0]} \
		${MCHS_PKG_CACHEDIR}/edk2-aarch64.rpm \
		${MCHS_PKG_SHA256[0]}
	mchs_download \
		${MCHS_PKG_SRCURL[1]} \
		${MCHS_PKG_CACHEDIR}/edk2-arm.rpm \
		${MCHS_PKG_SHA256[1]}
	mchs_download \
		${MCHS_PKG_SRCURL[2]} \
		${MCHS_PKG_CACHEDIR}/edk2-i686.rpm \
		${MCHS_PKG_SHA256[2]}
	mchs_download \
		${MCHS_PKG_SRCURL[3]} \
		${MCHS_PKG_CACHEDIR}/edk2-x86_64.rpm \
		${MCHS_PKG_SHA256[3]}

	local i
	for i in aarch64 arm i686 x86_64; do
		bsdtar xf ${MCHS_PKG_CACHEDIR}/edk2-${i}.rpm -C $MCHS_PREFIX/../
	done

	for i in $MCHS_PREFIX/share/qemu/firmware/*.json; do
		sed -i "s@/usr@$MCHS_PREFIX@g" $i
	done
}

mchs_step_install_license() {
	install -Dm600 $MCHS_PKG_BUILDER_DIR/License.txt \
		$MCHS_PREFIX/share/doc/ovmf/LICENSE.txt
}

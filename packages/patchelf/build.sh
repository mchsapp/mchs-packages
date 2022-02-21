MCHS_PKG_HOMEPAGE=https://nixos.org/patchelf.html
MCHS_PKG_DESCRIPTION="Utility to modify the dynamic linker and RPATH of ELF executables"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.14.3
MCHS_PKG_SRCURL=https://github.com/NixOS/patchelf/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=827a8ca914c69413f1ca0d967a637980a24edf000a938531a77e663317c853bb
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libc++"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	./bootstrap.sh
}

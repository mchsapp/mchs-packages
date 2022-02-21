MCHS_PKG_HOMEPAGE=https://www.dyne.org/software/frei0r/
MCHS_PKG_DESCRIPTION="Minimalistic plugin API for video effects"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.7.0
MCHS_PKG_SRCURL=https://files.dyne.org/frei0r/releases/frei0r-plugins-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=1b1ff8f0f9bc23eed724e94e9a7c1d8f0244bfe33424bb4fe68e6460c088523a
MCHS_PKG_DEPENDS="libc++, libcairo"
MCHS_PKG_FORCE_CMAKE=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DWITHOUT_GAVL=ON -DWITHOUT_OPENCV=ON"
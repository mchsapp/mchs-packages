MCHS_PKG_HOMEPAGE='https://craigbarnes.gitlab.io/dte/'
MCHS_PKG_DESCRIPTION='A small, configurable console text editor'
MCHS_PKG_LICENSE='GPL-2.0'
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.10
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL="https://craigbarnes.gitlab.io/dist/dte/dte-${MCHS_PKG_VERSION}.tar.gz"
MCHS_PKG_SHA256=db62aab235764f735adc8378f796d6474596582b7dae357e0bddf31304189800
MCHS_PKG_DEPENDS="libandroid-support, libandroid-glob, libiconv"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	export LDLIBS="-landroid-support -landroid-glob -liconv"
}

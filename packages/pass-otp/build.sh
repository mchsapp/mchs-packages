MCHS_PKG_HOMEPAGE=https://github.com/tadfisher/pass-otp
MCHS_PKG_DESCRIPTION="A pass extension for managing one-time-password (OTP) tokens"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="Henrik Grimler @Grimler91"
MCHS_PKG_VERSION=1.2.0
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/tadfisher/pass-otp/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=5720a649267a240a4f7ba5a6445193481070049c1d08ba38b00d20fc551c3a67
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="debianutils, oathtool, pass"
MCHS_PKG_SUGGESTS="libqrencode"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_pre_configure() {
	export BASHCOMPDIR=$MCHS_PREFIX/etc/bash_completion.d
}

MCHS_PKG_HOMEPAGE=https://aerc-mail.org/
MCHS_PKG_DESCRIPTION="A pretty good email client"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.7.1
MCHS_PKG_SRCURL=https://git.sr.ht/~rjarry/aerc/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=e149236623c103c8526b1f872b4e630e67f15be98ac604c0ea0186054dbef0cc
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	mchs_setup_golang
}

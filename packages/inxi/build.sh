MCHS_PKG_HOMEPAGE=https://github.com/smxi/inxi
MCHS_PKG_DESCRIPTION="Full featured CLI system information tool"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.3.08-1
MCHS_PKG_SRCURL=https://github.com/smxi/inxi/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=44008d9e77dc82855fd91d634f5f817813eb4653e4df7106e56a1c9986ab8abd
MCHS_PKG_DEPENDS="perl"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin/ inxi
	install -Dm600 -t $MCHS_PREFIX/share/man/man1/ inxi.1
}

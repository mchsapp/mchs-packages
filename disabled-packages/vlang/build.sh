MCHS_PKG_HOMEPAGE=https://github.com/vlang/v
MCHS_PKG_DESCRIPTION="Simple, fast, safe, compiled language for developing maintainable software"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.2.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/vlang/v/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=9152eec96d2eeb575782cf138cb837f315e48c173878857441d98ba679e3a9bf
MCHS_PKG_DEPENDS="clang"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_MAKE_ARGS="ANDROID=1"

mchs_step_make_install() {
	install -Dm700 v "$MCHS_PREFIX"/libexec/vlang/v
	ln -sfr "$MCHS_PREFIX"/libexec/vlang/v "$MCHS_PREFIX"/bin/v
	rm -rf "$MCHS_PREFIX"/libexec/vlang/vlib
	cp -a cmd vlib "$MCHS_PREFIX"/libexec/vlang/
}


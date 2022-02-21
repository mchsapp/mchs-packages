MCHS_PKG_HOMEPAGE=https://github.com/spook/sshping
MCHS_PKG_DESCRIPTION="measure character-echo latency and bandwidth for an interactive ssh session"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.1.4
MCHS_PKG_SRCURL=https://github.com/spook/sshping/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=589623e3fbe88dc1d423829e821f9d57f09aef0d9a2f04b7740b50909217863a
MCHS_PKG_DEPENDS="libssh"
MCHS_PKG_EXTRA_MAKE_ARGS="sshping man"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	rm -f CMakeLists.txt
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin ./bin/sshping
	install -Dm600 -t $MCHS_PREFIX/share/man/man8 ./doc/sshping.8
}

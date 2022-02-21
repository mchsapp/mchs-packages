MCHS_PKG_HOMEPAGE=https://mosh.org
MCHS_PKG_DESCRIPTION="Mobile shell that supports roaming and intelligent local echo"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3.2
MCHS_PKG_REVISION=34
MCHS_PKG_SRCURL=https://github.com/mobile-shell/mosh/releases/download/mosh-${MCHS_PKG_VERSION}/mosh-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=da600573dfa827d88ce114e0fed30210689381bbdcff543c931e4d6a2e851216
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+\.\d+\.\d+"
MCHS_PKG_DEPENDS="libandroid-support, libc++, libprotobuf, ncurses, openssl, openssh"

mchs_step_pre_configure() {
	mchs_setup_protobuf
}

mchs_step_post_make_install() {
	cd $MCHS_PREFIX/bin
	mv mosh mosh.pl
	$CXX $CXXFLAGS $LDFLAGS \
		-isystem $MCHS_PREFIX/include \
		-DPACKAGE_VERSION=\"$MCHS_PKG_VERSION\" \
		-std=c++11 -Wall -Wextra -Werror \
		$MCHS_PKG_BUILDER_DIR/mosh.cc -o mosh
}

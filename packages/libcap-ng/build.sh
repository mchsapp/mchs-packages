MCHS_PKG_HOMEPAGE=https://people.redhat.com/sgrubb/libcap-ng/
MCHS_PKG_DESCRIPTION="Library making programming with POSIX capabilities easier than traditional libcap"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1:0.8.3-pre1
MCHS_PKG_SRCURL="https://github.com/stevegrubb/libcap-ng/archive/187ed5355ce23333331187312c54d38390f3d6b6.tar.gz"
#MCHS_PKG_SRCURL=https://github.com/stevegrubb/libcap-ng/archive/v${MCHS_PKG_VERSION:2}.tar.gz
MCHS_PKG_SHA256=108e6be17b4c9b8c6249e5f12041fce4078de91515a00e93af400bfb40cfd538
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--without-python
--without-python3
"

mchs_step_pre_configure() {
	./autogen.sh
}

MCHS_PKG_HOMEPAGE=https://git.osgeo.org/gitea/rttopo/librttopo
MCHS_PKG_DESCRIPTION="The RT Topology Library exposes an API to create and manage standard topologies"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.1.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://git.osgeo.org/gitea/rttopo/librttopo/archive/librttopo-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=2e2fcabb48193a712a6c76ac9a9be2a53f82e32f91a2bc834d9f1b4fa9cd879f
MCHS_PKG_DEPENDS="libgeos, proj"
MCHS_PKG_GROUPS="science"

mchs_step_pre_configure() {
	./autogen.sh
}

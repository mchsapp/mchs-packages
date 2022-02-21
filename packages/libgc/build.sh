MCHS_PKG_HOMEPAGE=https://www.hboehm.info/gc/
MCHS_PKG_DESCRIPTION="Library providing the Boehm-Demers-Weiser conservative garbage collector"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=(8.0.6
                    7.6.12)
MCHS_PKG_SRCURL=(https://github.com/ivmai/bdwgc/releases/download/v$MCHS_PKG_VERSION/gc-$MCHS_PKG_VERSION.tar.gz
                   https://github.com/ivmai/libatomic_ops/releases/download/v${MCHS_PKG_VERSION[1]}/libatomic_ops-${MCHS_PKG_VERSION[1]}.tar.gz)
MCHS_PKG_SHA256=(3b4914abc9fa76593596773e4da671d7ed4d5390e3d46fbf2e5f155e121bea11
                   f0ab566e25fce08b560e1feab6a3db01db4a38e5bc687804334ef3920c549f3e)
MCHS_PKG_BREAKS="libgc-dev"
MCHS_PKG_REPLACES="libgc-dev"
MCHS_PKG_RM_AFTER_INSTALL="share/gc"


mchs_step_post_get_source() {
	mv libatomic_ops-${MCHS_PKG_VERSION[1]} libatomic_ops
	./autogen.sh
}

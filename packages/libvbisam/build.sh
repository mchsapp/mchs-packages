MCHS_PKG_HOMEPAGE=https://sourceforge.net/projects/vbisam/
MCHS_PKG_DESCRIPTION="A replacement for IBM's C-ISAM"
MCHS_PKG_LICENSE="GPL-2.0, LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/project/vbisam/vbisam2/vbisam-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=688b776e0030cce50fd7e44cbe40398ea93431f76510c7100433cc6313eabc4f

mchs_step_pre_configure() {
	cp $MCHS_PKG_BUILDER_DIR/efgcvt_r-template.c $MCHS_PKG_SRCDIR/libvbisam/
	cp $MCHS_PKG_BUILDER_DIR/efgcvt-dbl-macros.h $MCHS_PKG_SRCDIR/libvbisam/
	autoreconf -fi
}

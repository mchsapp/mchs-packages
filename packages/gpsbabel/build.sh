MCHS_PKG_HOMEPAGE=https://www.gpsbabel.org/
MCHS_PKG_DESCRIPTION="GPS file conversion plus transfer to/from GPS units"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
# 1.4.4 is the last version that does not require Qt dependency.
MCHS_PKG_VERSION=1.4.4
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/gpsbabel/gpsbabel/archive/gpsbabel_${MCHS_PKG_VERSION//./_}.tar.gz
MCHS_PKG_SHA256=22860e913f093aa9124e295d52d1d4ae1afccaa67ed6bed6f1f8d8b0a45336d1
MCHS_PKG_DEPENDS="libexpat"

mchs_step_post_get_source() {
	MCHS_PKG_SRCDIR+=/gpsbabel
}

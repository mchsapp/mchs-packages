MCHS_PKG_HOMEPAGE=https://github.com/pipeseroni/pipes.sh
MCHS_PKG_DESCRIPTION="Animated pipes terminal screensaver"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@Efreak"
MCHS_PKG_VERSION=2018.02.24
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/pipeseroni/pipes.sh/archive/581792d4e0ea51e15889ba14a85db1bc9727b83d.zip
MCHS_PKG_SHA256=79c7b29a687e24e0661e84cdc838520f6296470aa72f63d413cedd825d45fa1e
MCHS_PKG_AUTO_UPDATE=false
MCHS_PKG_DEPENDS=bash

mchs_step_make_install() {
	cd "$MCHS_PKG_SRCDIR"
	make install PREFIX=$MCHS_PREFIX
}

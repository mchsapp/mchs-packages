MCHS_PKG_HOMEPAGE=https://github.com/scop/bash-completion
MCHS_PKG_DESCRIPTION="Programmable completion for the bash shell"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.11
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/scop/bash-completion/releases/download/${MCHS_PKG_VERSION}/bash-completion-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=73a8894bad94dee83ab468fa09f628daffd567e8bef1a24277f1e9a0daf911ac
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="bash"
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_RM_AFTER_INSTALL="
share/bash-completion/completions/makepkg
"

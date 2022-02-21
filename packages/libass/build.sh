MCHS_PKG_HOMEPAGE=https://github.com/libass/libass
MCHS_PKG_DESCRIPTION="A portable library for SSA/ASS subtitles rendering"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.15.2
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://github.com/libass/libass/releases/download/$MCHS_PKG_VERSION/libass-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=1be2df9c4485a57d78bb18c0a8ed157bc87a5a8dd48c661961c625cb112832fd
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="fontconfig, fribidi, glib, harfbuzz"
MCHS_PKG_BREAKS="libass-dev"
MCHS_PKG_REPLACES="libass-dev"
# Avoid text relocations.
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_prog_nasm_check=no"

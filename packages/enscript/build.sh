MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/enscript/
MCHS_PKG_DESCRIPTION="Enscript converts ASCII text files to PostScript, HTML, RTF, ANSI and overstrikes"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.6.6
MCHS_PKG_REVISION=11
MCHS_PKG_SRCURL=https://ftp.gnu.org/gnu/enscript/enscript-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=6d56bada6934d055b34b6c90399aa85975e66457ac5bf513427ae7fc77f5c0bb
MCHS_PKG_DEPENDS="cups, perl"
MCHS_PKG_EXTRA_CONFIGURE_ARGS=" --sysconfdir=$MCHS_PREFIX/etc/enscript"

mchs_step_post_make_install() {
	cd "$MCHS_PREFIX"/bin && patch -i "$MCHS_PKG_BUILDER_DIR"/diffpp.patch.txt
	cd "$MCHS_PREFIX"/etc/enscript && patch -i "$MCHS_PKG_BUILDER_DIR"/enscript.cfg.patch.txt
}

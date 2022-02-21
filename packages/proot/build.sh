MCHS_PKG_HOMEPAGE=https://proot-me.github.io/
MCHS_PKG_DESCRIPTION="Emulate chroot, bind mount and binfmt_misc for non-root users"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="Michal Bednarski @michalbednarski"
# Just bump commit and version when needed:
_COMMIT=d4e4a07fbdc16e24868c295d3f7de97eca2a7f80
MCHS_PKG_VERSION=5.1.107
MCHS_PKG_REVISION=53
MCHS_PKG_SRCURL=https://github.com/mchs/proot/archive/${_COMMIT}.zip
MCHS_PKG_SHA256=c1572560806657f20639d6e3de4a156bed3fae49fa8f232aaa370846bf324f72
MCHS_PKG_DEPENDS="libtalloc"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_MAKE_ARGS="-C src"

# Install loader in libexec instead of extracting it every time
export PROOT_UNBUNDLE_LOADER=$MCHS_PREFIX/libexec/proot

mchs_step_pre_configure() {
	CPPFLAGS+=" -DARG_MAX=131072"
}

mchs_step_post_make_install() {
	mkdir -p $MCHS_PREFIX/share/man/man1
	install -m600 $MCHS_PKG_SRCDIR/doc/proot/man.1 $MCHS_PREFIX/share/man/man1/proot.1

	sed -e "s|@MCHS_PREFIX@|$MCHS_PREFIX|g" \
		$MCHS_PKG_BUILDER_DIR/mchs-chroot \
		> $MCHS_PREFIX/bin/mchs-chroot
	chmod 700 $MCHS_PREFIX/bin/mchs-chroot
}

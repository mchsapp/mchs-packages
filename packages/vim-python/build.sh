MCHS_PKG_HOMEPAGE=https://www.vim.org
MCHS_PKG_DESCRIPTION="Vi IMproved - enhanced vi editor"
MCHS_PKG_LICENSE="VIM License"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_DEPENDS="libiconv, ncurses, vim-runtime, python"
MCHS_PKG_RECOMMENDS="diffutils"
# vim should only be updated every 50 releases on multiples of 50.
# Update both vim and vim-python to the same version in one PR.
MCHS_PKG_VERSION=8.2.3800
MCHS_PKG_SRCURL="https://github.com/vim/vim/archive/v${MCHS_PKG_VERSION}.tar.gz"
MCHS_PKG_SHA256=5580c31980558612e7a1f85d0d73402b3feacc8ff174a70554cd2d0a44cd2966
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
vim_cv_getcwd_broken=no
vim_cv_memmove_handles_overlap=yes
vim_cv_stat_ignores_slash=no
vim_cv_terminfo=yes
vim_cv_tgetent=zero
vim_cv_toupper_broken=no
vim_cv_tty_group=world
--enable-gui=no
--enable-multibyte
--enable-netbeans=no
--with-features=huge
--without-x
--with-tlib=ncursesw
"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_RM_AFTER_INSTALL="
bin/rview
bin/rvim
bin/ex
share/man/man1/evim.1
share/icons
share/vim/vim82/spell/en.ascii*
share/vim/vim82/print
share/vim/vim82/tools
"
MCHS_PKG_CONFFILES="share/vim/vimrc"

# vim-python:
MCHS_PKG_CONFLICTS="vim"
MCHS_PKG_EXTRA_CONFIGURE_ARGS+="
vi_cv_path_python3_pfx=$MCHS_PREFIX
vi_cv_var_python3_abiflags=
vi_cv_var_python3_version=3.10
--enable-python3interp
--with-python3-config-dir=$MCHS_PREFIX/lib/python3.10/config-3.10/
"
MCHS_PKG_DESCRIPTION+=" - with python support"
# Remove share/vim/vim82 which is in vim-runtime built as a subpackage of vim:
MCHS_PKG_RM_AFTER_INSTALL+=" share/vim/vim82"
mchs_step_pre_configure() {
	CPPFLAGS+=" -I${MCHS_PREFIX}/include/python3.10"
}

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi

	make distclean

	# Remove eventually existing symlinks from previous builds so that they get re-created
	for b in rview rvim ex view vimdiff; do rm -f $MCHS_PREFIX/bin/$b; done
	rm -f $MCHS_PREFIX/share/man/man1/view.1
}

mchs_step_post_make_install() {
	sed -e "s%\@MCHS_PREFIX\@%${MCHS_PREFIX}%g" $MCHS_PKG_BUILDER_DIR/vimrc \
		> $MCHS_PREFIX/share/vim/vimrc

	# Remove most tutor files:
	cp $MCHS_PREFIX/share/vim/vim82/tutor/{tutor,tutor.vim,tutor.utf-8} $MCHS_PKG_TMPDIR/
	rm -f $MCHS_PREFIX/share/vim/vim82/tutor/*
	cp $MCHS_PKG_TMPDIR/{tutor,tutor.vim,tutor.utf-8} $MCHS_PREFIX/share/vim/vim82/tutor/
}

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$MCHS_PREFIX/bin/editor editor $MCHS_PREFIX/bin/vim 50
			update-alternatives --install \
				$MCHS_PREFIX/bin/vi vi $MCHS_PREFIX/bin/vim 20
		fi
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove editor $MCHS_PREFIX/bin/vim
			update-alternatives --remove vi $MCHS_PREFIX/bin/vim
		fi
	fi
	EOF
}

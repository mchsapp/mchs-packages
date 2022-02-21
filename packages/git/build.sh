MCHS_PKG_HOMEPAGE=https://git-scm.com/
MCHS_PKG_DESCRIPTION="Fast, scalable, distributed revision control system"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.35.1
MCHS_PKG_SRCURL=https://mirrors.kernel.org/pub/software/scm/git/git-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=d768528e6443f65a203036266f1ca50f9d127ba89751e32ead37117ed9191080
MCHS_PKG_DEPENDS="libcurl, libiconv, less, openssl, pcre2, zlib"

## This requires a working $MCHS_PREFIX/bin/sh on the host building:
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_fread_reads_directories=yes
ac_cv_header_libintl_h=no
ac_cv_iconv_omits_bom=no
ac_cv_snprintf_returns_bogus=no
--with-curl
--with-shell=$MCHS_PREFIX/bin/sh
--with-tcltk=$MCHS_PREFIX/bin/wish
"
# expat is only used by git-http-push for remote lock management over DAV, so disable:
# NO_INSTALL_HARDLINKS to use symlinks instead of hardlinks (which does not work on Android M):
MCHS_PKG_EXTRA_MAKE_ARGS="
NO_NSEC=1
NO_GETTEXT=1
NO_EXPAT=1
NO_INSTALL_HARDLINKS=1
PERL_PATH=$MCHS_PREFIX/bin/perl
USE_LIBPCRE2=1
"
MCHS_PKG_BUILD_IN_SRC=true

# Things to remove to save space:
#  bin/git-cvsserver - server emulating CVS
#  bin/git-shell - restricted login shell for Git-only SSH access
MCHS_PKG_RM_AFTER_INSTALL="
bin/git-cvsserver
bin/git-shell
libexec/git-core/git-shell
libexec/git-core/git-cvsserver
share/man/man1/git-cvsserver.1
share/man/man1/git-shell.1
"

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi

	# Setup perl so that the build process can execute it:
	rm -f $MCHS_PREFIX/bin/perl
	ln -s $(command -v perl) $MCHS_PREFIX/bin/perl

	# Force fresh perl files (otherwise files from earlier builds
	# remains without bumped modification times, so are not picked
	# up by the package):
	rm -Rf $MCHS_PREFIX/share/git-perl

	# Fixes build if utfcpp is installed:
	CPPFLAGS="-I$MCHS_PKG_SRCDIR $CPPFLAGS"
}

mchs_step_make() {
	make -j $MCHS_MAKE_PROCESSES $MCHS_PKG_EXTRA_MAKE_ARGS
	make -j $MCHS_MAKE_PROCESSES -C contrib/subtree $MCHS_PKG_EXTRA_MAKE_ARGS
}

mchs_step_make_install() {
	make $MCHS_PKG_EXTRA_MAKE_ARGS install
	make -C contrib/subtree $MCHS_PKG_EXTRA_MAKE_ARGS install

	# Installing man requires asciidoc and xmlto, so git uses separate make targets for man pages
	make -j $MCHS_MAKE_PROCESSES install-man
	make -j $MCHS_MAKE_PROCESSES -C contrib/subtree install-man
}

mchs_step_post_make_install() {
	mkdir -p $MCHS_PREFIX/etc/bash_completion.d/
	cp $MCHS_PKG_SRCDIR/contrib/completion/git-completion.bash \
	   $MCHS_PKG_SRCDIR/contrib/completion/git-prompt.sh \
	   $MCHS_PREFIX/etc/bash_completion.d/

	# Remove the build machine perl setup in mchs_step_pre_configure to avoid it being packaged:
	rm $MCHS_PREFIX/bin/perl

	# Remove clutter:
	rm -Rf $MCHS_PREFIX/lib/*-linux*/perl

	# Remove duplicated binaries in bin/ with symlink to the one in libexec/git-core:
	(cd $MCHS_PREFIX/bin; ln -s -f ../libexec/git-core/git git)
	(cd $MCHS_PREFIX/bin; ln -s -f ../libexec/git-core/git-upload-pack git-upload-pack)
}

mchs_step_post_massage() {
	if [ ! -f libexec/git-core/git-remote-https ]; then
		mchs_error_exit "Git built without https support"
	fi
}

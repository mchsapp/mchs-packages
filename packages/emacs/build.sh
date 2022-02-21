MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/emacs/
MCHS_PKG_DESCRIPTION="Extensible, customizable text editor-and more"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=27.2
MCHS_PKG_REVISION=9
MCHS_PKG_SRCURL=https://ftp.gnu.org/gnu/emacs/emacs-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=b4a7cc4e78e63f378624e0919215b910af5bb2a0afc819fad298272e9f40c1b9
MCHS_PKG_DEPENDS="ncurses, gnutls, libxml2, libjansson"
MCHS_PKG_BREAKS="emacs-dev"
MCHS_PKG_REPLACES="emacs-dev"
MCHS_PKG_SERVICE_SCRIPT=("emacsd" 'exec emacs --fg-daemon 2>&1')
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-autodepend
--with-gif=no
--with-gnutls
--with-jpeg=no
--without-gconf
--without-gsettings
--without-lcms2
--without-x
--with-png=no
--with-tiff=no
--with-xml2
--with-xpm=no
--without-dbus
--without-selinux
--with-modules
--with-pdumper=yes
--with-dumping=none
--with-json
"

if $MCHS_DEBUG_BUILD; then
	MCHS_PKG_EXTRA_CONFIGURE_ARGS+="
	--enable-checking=yes,glyphs
	--enable-check-lisp-object-type
	"
	CFLAGS+=" -gdwarf-4"
fi

# Ensure use of system malloc:
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" emacs_cv_sanitize_address=yes"
# Prevent configure from adding -nopie:
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" emacs_cv_prog_cc_no_pie=no"
# Prevent linking against libelf:
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_lib_elf_elf_begin=no"
# implemented using dup3(), which fails if oldfd == newfd
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" gl_cv_func_dup2_works=no"
# disable setrlimit function to make mchs-am work from within emacs
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_setrlimit=no"
if [ "$MCHS_ARCH" == "arm" ] || [ "$MCHS_ARCH" == "i686" ]; then
	# setjmp does not work properly on 32bit android:
	# https://github.com/mchs/mchs-packages/issues/2599
	MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" emacs_cv_func__setjmp=no"
	MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" emacs_cv_func_sigsetjmp=no"
fi
MCHS_PKG_HOSTBUILD=true

# Remove some irrelevant files:
MCHS_PKG_RM_AFTER_INSTALL="
bin/grep-changelog
share/applications/emacs.desktop
share/emacs/${MCHS_PKG_VERSION}/etc/emacs.desktop
share/emacs/${MCHS_PKG_VERSION}/etc/emacs.icon
share/emacs/${MCHS_PKG_VERSION}/etc/images
share/emacs/${MCHS_PKG_VERSION}/etc/refcards
share/emacs/${MCHS_PKG_VERSION}/etc/tutorials/TUTORIAL.*
share/icons
share/man/man1/grep-changelog.1.gz
"

# Remove ctags from the emacs package to prevent conflicting with
# the Universal Ctags from the 'ctags' package (the bin/etags
# program still remain in the emacs package):
MCHS_PKG_RM_AFTER_INSTALL+=" bin/ctags share/man/man1/ctags.1 share/man/man1/ctags.1.gz"


mchs_step_post_get_source() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi

	# XXX: We have to start with new host build each time
	#      to avoid build error when cross compiling.
	rm -Rf $MCHS_PKG_HOSTBUILD_DIR

	# McHs only use info pages for emacs. Remove the info directory
	# to get a clean Info directory file dir.
	rm -Rf $MCHS_PREFIX/share/info
}

mchs_step_host_build() {
	# Build a bootstrap-emacs binary to be used in mchs_step_post_configure.
	local NATIVE_PREFIX=$MCHS_PKG_TMPDIR/emacs-native
	mkdir -p $NATIVE_PREFIX/share/emacs/$MCHS_PKG_VERSION
	ln -s $MCHS_PKG_SRCDIR/lisp $NATIVE_PREFIX/share/emacs/$MCHS_PKG_VERSION/lisp
	( cd $MCHS_PKG_SRCDIR; ./autogen.sh )
	$MCHS_PKG_SRCDIR/configure --prefix=$NATIVE_PREFIX --without-all --without-x
	make -j $MCHS_MAKE_PROCESSES
}

mchs_step_post_configure() {
	cp $MCHS_PKG_HOSTBUILD_DIR/src/bootstrap-emacs $MCHS_PKG_BUILDDIR/src/bootstrap-emacs
	cp $MCHS_PKG_HOSTBUILD_DIR/lib-src/make-docfile $MCHS_PKG_BUILDDIR/lib-src/make-docfile
	cp $MCHS_PKG_HOSTBUILD_DIR/lib-src/make-fingerprint $MCHS_PKG_BUILDDIR/lib-src/make-fingerprint
	# Update timestamps so that the binaries does not get rebuilt:
	touch -d "next hour" $MCHS_PKG_BUILDDIR/src/bootstrap-emacs \
		$MCHS_PKG_BUILDDIR/lib-src/make-docfile \
		$MCHS_PKG_BUILDDIR/lib-src/make-fingerprint
}

mchs_step_post_make_install() {
	install -Dm600 $MCHS_PKG_BUILDER_DIR/site-start.el \
		$MCHS_PREFIX/share/emacs/site-lisp/site-start.el
}

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$MCHS_PREFIX/bin/editor editor $MCHS_PREFIX/bin/emacs 40
		fi
	fi

	cd $MCHS_PREFIX/share/emacs/$MCHS_PKG_VERSION/lisp
	LC_ALL=C $MCHS_PREFIX/bin/emacs -batch -l loadup --temacs=pdump
	mv $MCHS_PREFIX/bin/emacs*.pdmp $MCHS_PREFIX/libexec/emacs/$MCHS_PKG_VERSION/${MCHS_ARCH}-linux-android*/
	EOF

	cat <<- EOF > ./prerm
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove editor $MCHS_PREFIX/bin/emacs
		fi
	fi
	EOF
}

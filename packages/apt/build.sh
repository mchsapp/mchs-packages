MCHS_PKG_HOMEPAGE=https://packages.debian.org/apt
MCHS_PKG_DESCRIPTION="Front-end for the dpkg package manager"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.3.15
MCHS_PKG_SRCURL=https://deb.debian.org/debian/pool/main/a/apt/apt_${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=2562007d110993dd7e7a86dd81ea650e61210179b59eac72b6edff6364c0bba6
# apt-key requires utilities from coreutils, findutils, gpgv, grep, sed.
MCHS_PKG_DEPENDS="coreutils, dpkg, findutils, gpgv, grep, libandroid-glob, libbz2, libc++, libcurl, libgnutls, liblz4, liblzma, sed, mchs-keyring, mchs-licenses, xxhash, zlib"
MCHS_PKG_BUILD_DEPENDS="docbook-xsl"
MCHS_PKG_CONFLICTS="apt-transport-https, libapt-pkg"
MCHS_PKG_REPLACES="apt-transport-https, libapt-pkg, unstable-repo, game-repo, science-repo"
MCHS_PKG_PROVIDES="unstable-repo, game-repo, science-repo"
MCHS_PKG_SUGGESTS="gnupg, x11-repo"
MCHS_PKG_ESSENTIAL=true

MCHS_PKG_CONFFILES="
etc/apt/sources.list
etc/apt/trusted.gpg
"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DPERL_EXECUTABLE=$(command -v perl)
-DCMAKE_INSTALL_FULL_LOCALSTATEDIR=$MCHS_PREFIX
-DCACHE_DIR=${MCHS_CACHE_DIR}/apt
-DCOMMON_ARCH=$MCHS_ARCH
-DDPKG_DATADIR=$MCHS_PREFIX/share/dpkg
-DUSE_NLS=OFF
-DWITH_DOC=OFF
"

# ubuntu uses instead $PREFIX/lib instead of $PREFIX/libexec to
# "Work around bug in GNUInstallDirs" (from apt 1.4.8 CMakeLists.txt).
# Archlinux uses $PREFIX/libexec though, so let's force libexec->lib to
# get same build result on ubuntu and archlinux.
MCHS_PKG_EXTRA_CONFIGURE_ARGS+="-DCMAKE_INSTALL_LIBEXECDIR=lib"

MCHS_PKG_RM_AFTER_INSTALL="
bin/apt-cdrom
bin/apt-extracttemplates
bin/apt-sortpkgs
etc/apt/apt.conf.d
lib/apt/methods/cdrom
lib/apt/methods/mirror*
lib/apt/methods/rred
lib/apt/planners/
lib/apt/solvers/
lib/dpkg/
share/man/man1/apt-extracttemplates.1
share/man/man1/apt-sortpkgs.1
share/man/man1/apt-transport-mirror.1
share/man/man8/apt-cdrom.8
"

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi

	# Fix i686 builds.
	CXXFLAGS+=" -Wno-c++11-narrowing"
	# Fix glob() on Android 7.
	LDFLAGS+=" -Wl,--no-as-needed -landroid-glob"

	# for manpage build
	local docbook_xsl_version=$(. $MCHS_SCRIPTDIR/packages/docbook-xsl/build.sh; echo $MCHS_PKG_VERSION)
	MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" -DDOCBOOK_XSL=$MCHS_PREFIX/share/xml/docbook/xsl-stylesheets-$docbook_xsl_version-nons"
}

mchs_step_post_make_install() {
	printf "# The main mchs repository:\ndeb https://packages.mchs.org/apt/mchs-main/ stable main\n" > $MCHS_PREFIX/etc/apt/sources.list
	cp $MCHS_PKG_BUILDER_DIR/trusted.gpg $MCHS_PREFIX/etc/apt/

	# apt-transport-tor
	ln -sfr $MCHS_PREFIX/lib/apt/methods/http $MCHS_PREFIX/lib/apt/methods/tor
	ln -sfr $MCHS_PREFIX/lib/apt/methods/http $MCHS_PREFIX/lib/apt/methods/tor+http
	ln -sfr $MCHS_PREFIX/lib/apt/methods/https $MCHS_PREFIX/lib/apt/methods/tor+https
}

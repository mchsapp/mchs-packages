MCHS_PKG_HOMEPAGE=https://packages.debian.org/dpkg
MCHS_PKG_DESCRIPTION="Debian package management system"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.21.1
MCHS_PKG_SRCURL=https://mirrors.kernel.org/debian/pool/main/d/dpkg/dpkg_${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=1eb9fd5228b3199284ea5134904bb45b7a5bc12fb044b8e4964d89d2e5bbb563
MCHS_PKG_DEPENDS="bzip2, coreutils, diffutils, gzip, less, libbz2, liblzma, tar, xz-utils, zlib"
MCHS_PKG_BREAKS="dpkg-dev"
MCHS_PKG_REPLACES="dpkg-dev"
MCHS_PKG_ESSENTIAL=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_selinux_setexecfilecon=no
--disable-dselect
--disable-largefile
--disable-shared
dpkg_cv_c99_snprintf=yes
HAVE_SETEXECFILECON_FALSE=#
--host=${MCHS_ARCH}-linux
--without-selinux
"

MCHS_PKG_RM_AFTER_INSTALL="
bin/dpkg-architecture
bin/dpkg-buildflags
bin/dpkg-buildpackage
bin/dpkg-checkbuilddeps
bin/dpkg-distaddfile
bin/dpkg-genbuildinfo
bin/dpkg-genchanges
bin/dpkg-gencontrol
bin/dpkg-gensymbols
bin/dpkg-maintscript-helper
bin/dpkg-mergechangelogs
bin/dpkg-name
bin/dpkg-parsechangelog
bin/dpkg-scanpackages
bin/dpkg-scansources
bin/dpkg-shlibdeps
bin/dpkg-source
bin/dpkg-statoverride
bin/dpkg-vendor
include
lib
share/dpkg
share/man/man1/dpkg-architecture.1
share/man/man1/dpkg-buildflags.1
share/man/man1/dpkg-buildpackage.1
share/man/man1/dpkg-checkbuilddeps.1
share/man/man1/dpkg-distaddfile.1
share/man/man1/dpkg-genbuildinfo.1
share/man/man1/dpkg-genchanges.1
share/man/man1/dpkg-gencontrol.1
share/man/man1/dpkg-gensymbols.1
share/man/man1/dpkg-maintscript-helper.1
share/man/man1/dpkg-mergechangelogs.1
share/man/man1/dpkg-name.1
share/man/man1/dpkg-parsechangelog.1
share/man/man1/dpkg-scanpackages.1
share/man/man1/dpkg-scansources.1
share/man/man1/dpkg-shlibdeps.1
share/man/man1/dpkg-source.1
share/man/man1/dpkg-statoverride.1
share/man/man1/dpkg-vendor.1
share/man/man3
share/man/man5
share/perl5
share/polkit-1
"

mchs_step_pre_configure() {
	export TAR=tar # To make sure dpkg tries to use "tar" instead of e.g. "gnutar" (which happens when building on OS X)
	perl -p -i -e "s/MCHS_ARCH/$MCHS_ARCH/" $MCHS_PKG_SRCDIR/configure
	sed -i 's/$req_vars = \$arch_vars.$varname./if ($varname eq "DEB_HOST_ARCH_CPU" or $varname eq "DEB_HOST_ARCH"){ print("'$MCHS_ARCH'");exit; }; $req_vars = $arch_vars{$varname}/' scripts/dpkg-architecture.pl
}

mchs_step_post_massage() {
	mkdir -p "${MCHS_PKG_MASSAGEDIR}/${MCHS_PREFIX}/var/lib/dpkg/alternatives"
	mkdir -p "${MCHS_PKG_MASSAGEDIR}/${MCHS_PREFIX}/var/lib/dpkg/info"
	mkdir -p "${MCHS_PKG_MASSAGEDIR}/${MCHS_PREFIX}/var/lib/dpkg/triggers"
	mkdir -p "${MCHS_PKG_MASSAGEDIR}/${MCHS_PREFIX}/var/lib/dpkg/updates"
}

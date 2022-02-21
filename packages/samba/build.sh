MCHS_PKG_HOMEPAGE=https://www.samba.org/
MCHS_PKG_DESCRIPTION="SMB/CIFS fileserver"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.14.12
MCHS_PKG_SRCURL=https://download.samba.org/pub/samba/samba-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=155d9c2dfb06a18104422987590858bfe5e9783ebebe63882e7e7f07eaaa512d
MCHS_PKG_DEPENDS="libbsd, libcap, libcrypt, libgnutls, libiconv, libicu, libpopt, libtalloc, libtirpc, ncurses, openssl, readline, zlib"
MCHS_PKG_BUILD_DEPENDS="e2fsprogs"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
	:
}

mchs_step_make() {
	:
}

mchs_step_make_install() {
	local _auth_modules='auth_server,auth_netlogond,auth_script'
	local _pdb_modules='pdb_tdbsam,pdb_smbpasswd,pdb_wbc_sam'
	local _vfs_modules='vfs_fake_perms,!vfs_recycle,!vfs_btrfs,!vfs_glusterfs_fuse'
	_vfs_modules+=',!vfs_virusfilter,!vfs_linux_xfs_sgid,!vfs_shell_snap,!vfs_expand_msdfs,!vfs_snapper'
	_vfs_modules+=',!vfs_default_quota,!vfs_audit,!vfs_extd_audit,!vfs_full_audit'
	_vfs_modules+=',!vfs_worm,!vfs_time_audit,!vfs_media_harmony,!vfs_unityed_media,!vfs_shadow_copy,!vfs_shadow_copy2'

	cd "$MCHS_PKG_SRCDIR"

	cat <<EOF > cross-answers.txt
Checking uname sysname type: "Linux"
Checking uname machine type: "$MCHS_ARCH"
Checking uname release type: "dontcare"
Checking uname version type: "dontcare"
Checking simple C program: "hello world"
rpath library support: OK
-Wl,--version-script support: NO
Checking getconf LFS_CFLAGS: NO
Checking for large file support without additional flags: OK
Checking for -D_FILE_OFFSET_BITS=64: OK
Checking for -D_LARGE_FILES: OK
Checking correct behavior of strtoll: NO
Checking for working strptime: NO
Checking for C99 vsnprintf: OK
Checking for HAVE_SHARED_MMAP: OK
Checking for HAVE_MREMAP: OK
Checking for HAVE_INCOHERENT_MMAP: NO
Checking for HAVE_SECURE_MKSTEMP: OK
Checking value of NSIG: "65"
Checking value of _NSIG: "65"
Checking value of SIGRTMAX: "64"
Checking value of SIGRTMIN: "36"
Checking for a 64-bit host to support lmdb: OK
Checking value of GNUTLS_CIPHER_AES_128_CFB8: "29"
Checking value of GNUTLS_MAC_AES_CMAC_128: "203"
Checking errno of iconv for illegal multibyte sequence: OK
Checking for kernel change notify support: OK
Checking for Linux kernel oplocks: OK
Checking for kernel share modes: OK
Checking whether POSIX capabilities are available: OK
Checking if can we convert from CP850 to UCS-2LE: OK
Checking if can we convert from UTF-8 to UCS-2LE: OK
vfs_fileid checking for statfs() and struct statfs.f_fsid: OK
Checking whether we can use Linux thread-specific credentials: NO
Checking whether setreuid is available: NO
Checking whether setresuid is available: NO
Checking whether seteuid is available: NO
Checking whether setuidx is available: NO
Checking whether fcntl locking is available: OK
Checking whether fcntl lock supports open file description locks: OK
Checking whether fcntl supports flags to send direct I/O availability signals: OK
Checking whether fcntl supports setting/geting hints: NO
Checking for the maximum value of the 'time_t' type: NO
Checking whether the realpath function allows a NULL argument: OK
Checking for ftruncate extend: OK
getcwd takes a NULL argument: OK
EOF

	USING_SYSTEM_ASN1_COMPILE=1 ASN1_COMPILE=/usr/bin/asn1_compile \
	USING_SYSTEM_COMPILE_ET=1 COMPILE_ET=/usr/bin/compile_et \
	CFLAGS="-D__ANDROID_API__=24 -D__USE_FILE_OFFSET64=1" \
	./buildtools/bin/waf configure \
		--jobs="$MCHS_MAKE_PROCESSES" \
		--bundled-libraries='!asn1_compile,!compile_et' \
		--cross-compile \
		--cross-answers=cross-answers.txt \
		--enable-fhs \
		--prefix="$MCHS_PREFIX" \
		--sysconfdir="$MCHS_PREFIX/etc" \
		--localstatedir="$MCHS_PREFIX/var" \
		--sbindir="$MCHS_PREFIX/bin" \
		--disable-avahi \
		--disable-cephfs \
		--disable-cups \
		--disable-glusterfs \
		--disable-iprint \
		--disable-python \
		--nopyc \
		--nopyo \
		--disable-rpath \
		--disable-rpath-install \
		--disable-spotlight \
		--without-acl-support \
		--without-ad-dc \
		--without-ads \
		--without-automount \
		--without-dmapi \
		--without-dnsupdate \
		--without-fam \
		--without-gettext \
		--with-gpfs=/dev/null \
		--without-gpgme \
		--without-json \
		--without-ldap \
		--without-ldb-lmdb \
		--without-libarchive \
		--without-lttng \
		--without-ntvfs-fileserver \
		--without-pam \
		--without-quotas \
		--without-regedit \
		--without-systemd \
		--without-utmp \
		--without-winbind \
		--with-shared-modules="${_vfs_modules},${_pdb_modules},${_auth_modules}" \
		--with-static-modules='!auth_winbind'
		# --disable-fault-handling \
		# --disable-rpath-private-install \
		# --with-logfilebase="$MCHS_PREFIX/tmp/log/samba" \

	./buildtools/bin/waf install --jobs="$MCHS_MAKE_PROCESSES"

	mkdir -p "$MCHS_PREFIX/share/doc/samba"
	sed -e "s|@MCHS_PREFIX@|${MCHS_PREFIX}|g" \
		"$MCHS_PKG_BUILDER_DIR/smb.conf.example.in" \
		> "$MCHS_PREFIX/share/doc/samba/smb.conf.example"
}

mchs_step_post_massage() {
	# keep empty dirs which were deleted in massage
	mkdir -p "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/var/lib/samba/bind-dns" "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/var/lib/samba/private"
	for dir in cache lock log run; do
		mkdir -p "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/var/$dir/samba"
	done
	# 755 - as opposed to 700 - because testparm throws up a warning otherwise
	chmod 755 "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/var/lock/samba" "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/var/lib/samba" "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/var/cache/samba"
}

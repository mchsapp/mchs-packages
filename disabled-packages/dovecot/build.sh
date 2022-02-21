MCHS_PKG_HOMEPAGE=https://www.dovecot.org
MCHS_PKG_DESCRIPTION="Secure IMAP and POP3 email server"
MCHS_PKG_VERSION=2.2.31
MCHS_PKG_SRCURL=https://www.dovecot.org/releases/2.2/dovecot-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=034be40907748128d65088a4f59789b2f99ae7b33a88974eae0b6a68ece376a1
MCHS_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
MCHS_PKG_DEPENDS="openssl, libcrypt"
# turning on icu gives undefined reference to __cxa_call_unexpected
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--with-zlib
--with-ssl=openssl
--with-ssldir=$MCHS_PREFIX/etc/tls
--without-icu
--without-shadow
i_cv_epoll_works=yes
i_cv_posix_fallocate_works=yes
i_cv_signed_size_t=no
i_cv_gmtime_max_time_t=40
i_cv_signed_time_t=yes
i_cv_mmap_plays_with_write=yes
i_cv_fd_passing=yes
i_cv_c99_vsnprintf=yes
lib_cv_va_copy=yes
lib_cv___va_copy=yes
"

mchs_step_pre_configure() {
	LDFLAGS="$LDFLAGS -llog"

	for i in $(find $MCHS_PKG_SRCDIR/src/director -type f); do sed 's|\bstruct user\b|struct usertest|g' -i $i; done

	if [ "$MCHS_ARCH" == "aarch64" ]; then
		MCHS_PKG_EXTRA_CONFIGURE_ARGS+="lib_cv_va_val_copy=yes"
	else
		MCHS_PKG_EXTRA_CONFIGURE_ARGS+="lib_cv_va_val_copy=no"
	fi
}

mchs_step_post_make_install() {
	for binary in doveadm doveconf; do
		mv $MCHS_PREFIX/bin/$binary $MCHS_PREFIX/libexec/dovecot/$binary
		cat > $MCHS_PREFIX/bin/$binary <<HERE
#!$MCHS_PREFIX/bin/sh
export LD_LIBRARY_PATH=$MCHS_PREFIX/lib/dovecot:\$LD_LIBRARY_PATH
exec $MCHS_PREFIX/libexec/dovecot/$binary $@
HERE
		chmod u+x $MCHS_PREFIX/bin/$binary
	done
}

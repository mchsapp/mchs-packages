MCHS_PKG_HOMEPAGE=https://www.postgresql.org
MCHS_PKG_DESCRIPTION="Object-relational SQL database"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_LICENSE_FILE="COPYRIGHT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=14.2
MCHS_PKG_SRCURL=https://ftp.postgresql.org/pub/source/v$MCHS_PKG_VERSION/postgresql-$MCHS_PKG_VERSION.tar.bz2
MCHS_PKG_SHA256=2cf78b2e468912f8101d695db5340cf313c2e9f68a612fb71427524e8c9a977a
MCHS_PKG_DEPENDS="openssl, libcrypt, readline, libandroid-shmem, libuuid, libxml2, libicu, zlib"
MCHS_PKG_BUILD_DEPENDS="libandroid-posix-semaphore"
# - pgac_cv_prog_cc_ldflags__Wl___as_needed: Inform that the linker supports as-needed. It's
#   not stricly necessary but avoids unnecessary linking of binaries.
# - USE_UNNAMED_POSIX_SEMAPHORES: Avoid using System V semaphores which are disabled on Android.
# - ZIC=...: The zic tool is used to build the time zone database bundled with postgresql.
#   We specify a binary built in mchs_step_host_build which has been patched to use symlinks
#   over hard links (which are not supported as of Android 6.0+).
#   There exists a --with-system-tzdata configure flag, but that does not work here as Android
#   uses a custom combined tzdata file.
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
pgac_cv_prog_cc_ldflags__Wl___as_needed=yes
USE_UNNAMED_POSIX_SEMAPHORES=1
--with-icu
--with-libxml
--with-openssl
--with-uuid=e2fs
ZIC=$MCHS_PKG_HOSTBUILD_DIR/src/timezone/zic
"
MCHS_PKG_EXTRA_MAKE_ARGS=" -s"
MCHS_PKG_RM_AFTER_INSTALL="lib/libecpg* bin/ecpg share/man/man1/ecpg.1"
MCHS_PKG_HOSTBUILD=true
MCHS_PKG_BREAKS="postgresql-contrib (<= 10.3-1), postgresql-dev"
MCHS_PKG_REPLACES="postgresql-contrib (<= 10.3-1), postgresql-dev"
MCHS_PKG_SERVICE_SCRIPT=("postgres" "mkdir -p ~/.postgres\nif [ -f \"~/.postgres/postgresql.conf\" ]; then DATADIR=\"~/.postgres\"; else DATADIR=\"$MCHS_PREFIX/var/lib/postgresql\"; fi\nexec postgres -D \$DATADIR 2>&1")

mchs_step_host_build() {
	# Build a native zic binary which we have patched to
	# use symlinks instead of hard links.
	$MCHS_PKG_SRCDIR/configure --without-readline
	make
}

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi
}

mchs_step_post_make_install() {
	# Man pages are not installed by default:
	make -C doc/src/sgml install-man

	for contrib in \
		hstore \
		citext \
		dblink \
		pageinspect \
		pgcrypto \
		pgrowlocks \
		pg_freespacemap \
		pg_stat_statements\
		pg_trgm \
		postgres_fdw \
		fuzzystrmatch \
		unaccent \
		uuid-ossp \
		btree_gist \
		; do
		(cd contrib/$contrib && make -s -j $MCHS_MAKE_PROCESSES install)
	done
}

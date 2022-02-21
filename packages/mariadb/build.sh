MCHS_PKG_HOMEPAGE=https://mariadb.org
MCHS_PKG_DESCRIPTION="A drop-in replacement for mysql server"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2:10.6.4
MCHS_PKG_REVISION=6
MCHS_PKG_SRCURL=http://ftp.hosteurope.de/mirror/archive.mariadb.org/mariadb-${MCHS_PKG_VERSION:2}/source/mariadb-${MCHS_PKG_VERSION:2}.tar.gz
MCHS_PKG_SHA256=75bf9b147a95d38160d01a73b098d50a1960563b46d16a235971fff64d99643c
MCHS_PKG_DEPENDS="libc++, libiconv, liblzma, ncurses, libedit, openssl, pcre2, libcrypt, libandroid-support, libandroid-glob, zlib, liblz4"
MCHS_PKG_BREAKS="mariadb-dev"
MCHS_PKG_REPLACES="mariadb-dev"
MCHS_PKG_SERVICE_SCRIPT=("mysqld" "exec mysqld --basedir=$MCHS_PREFIX --datadir=$MCHS_PREFIX/var/lib/mysql 2>&1")

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DBISON_EXECUTABLE=$(command -v bison)
-DGETCONF=$(command -v getconf)
-DBUILD_CONFIG=mysql_release
-DCAT_EXECUTABLE=$(command -v cat)
-DGIT_EXECUTABLE=$(command -v git)
-DGSSAPI_FOUND=NO
-DGRN_WITH_LZ4=yes
-DENABLED_LOCAL_INFILE=ON
-DHAVE_UCONTEXT_H=False
-DIMPORT_EXECUTABLES=$MCHS_PKG_HOSTBUILD_DIR/import_executables.cmake
-DINSTALL_LAYOUT=DEB
-DINSTALL_UNIX_ADDRDIR=$MCHS_PREFIX/var/run/mysqld.sock
-DINSTALL_SBINDIR=$MCHS_PREFIX/bin
-DMYSQL_DATADIR=$MCHS_PREFIX/var/lib/mysql
-DPLUGIN_AUTH_GSSAPI_CLIENT=OFF
-DPLUGIN_AUTH_GSSAPI=NO
-DPLUGIN_AUTH_PAM=NO
-DPLUGIN_CONNECT=NO
-DPLUGIN_DAEMON_EXAMPLE=NO
-DPLUGIN_EXAMPLE=NO
-DPLUGIN_GSSAPI=OFF
-DPLUGIN_ROCKSDB=NO
-DPLUGIN_TOKUDB=NO
-DPLUGIN_SERVER_AUDIT=NO
-DSTACK_DIRECTION=-1
-DTMPDIR=$MCHS_PREFIX/tmp
-DWITH_EXTRA_CHARSETS=complex
-DWITH_JEMALLOC=OFF
-DWITH_MARIABACKUP=OFF
-DWITH_PCRE=system
-DWITH_LZ4=system
-DWITH_READLINE=OFF
-DWITH_SSL=system
-DWITH_WSREP=False
-DWITH_ZLIB=system
-DWITH_INNODB_BZIP2=OFF
-DWITH_INNODB_LZ4=ON
-DWITH_INNODB_LZMA=ON
-DWITH_INNODB_LZO=OFF
-DWITH_INNODB_SNAPPY=OFF
-DWITH_UNIT_TESTS=OFF
-DINSTALL_SYSCONFDIR=$MCHS_PREFIX/etc
"
MCHS_PKG_HOSTBUILD=true
MCHS_PKG_CONFLICTS="mysql"

MCHS_PKG_RM_AFTER_INSTALL="
bin/mysqltest*
share/man/man1/mysql-test-run.pl.1
share/mysql/mysql-test
mysql-test
sql-bench
"

# i686 build fails due to:
#  /home/builder/.mchs-build/mariadb/src/include/my_pthread.h:822:10: error: use of undeclared identifier 'my_atomic_add32'
#    (void) my_atomic_add32_explicit(value, 1, MY_MEMORY_ORDER_RELAXED);
MCHS_PKG_BLACKLISTED_ARCHES="i686"

mchs_step_host_build() {
	mchs_setup_cmake
	sed -i 's/^\s*END[(][)]/ENDIF()/g' $MCHS_PKG_SRCDIR/libmariadb/cmake/ConnectorName.cmake
	cmake -G "Unix Makefiles" \
		$MCHS_PKG_SRCDIR \
		-DWITH_SSL=bundled \
		-DCMAKE_BUILD_TYPE=Release
	make -j $MCHS_MAKE_PROCESSES import_executables
}

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi

	CPPFLAGS+=" -Dushort=u_short"

	if [ $MCHS_ARCH_BITS = 32 ]; then
		CPPFLAGS+=" -D__off64_t_defined"
	fi

	if [ $MCHS_ARCH = "i686" ]; then
		# Avoid undefined reference to __atomic_load_8:
		CFLAGS+=" -latomic"
	fi
	sed -i 's/^\s*END[(][)]/ENDIF()/g' $MCHS_PKG_SRCDIR/libmariadb/cmake/ConnectorName.cmake
}

mchs_step_post_massage() {
	mkdir -p $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/etc/my.cnf.d
}

mchs_step_create_debscripts() {
	echo "if [ ! -e "$MCHS_PREFIX/var/lib/mysql" ]; then" > postinst
	echo "  echo 'Initializing mysql data directory...'" >> postinst
	echo "  mkdir -p $MCHS_PREFIX/var/lib/mysql" >> postinst
	echo "  $MCHS_PREFIX/bin/mysql_install_db --user=\$(whoami) --datadir=$MCHS_PREFIX/var/lib/mysql --basedir=$MCHS_PREFIX" >> postinst
	echo "fi" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}

MCHS_SUBPKG_DESCRIPTION="A set of utilities for working with the QEMU emulators"
MCHS_SUBPKG_DEPENDS="glib, libbz2, libcap-ng, libcurl, libgnutls, libnettle, libnfs, libpixman, libssh, zlib, zstd"
MCHS_SUBPKG_DEPEND_ON_PARENT=no

MCHS_SUBPKG_INCLUDE="
bin/elf2dmp
bin/qemu-edid
bin/qemu-img
bin/qemu-io
bin/qemu-nbd
share/man/man1/qemu-img.1.gz
share/man/man8/qemu-nbd.8.gz
"

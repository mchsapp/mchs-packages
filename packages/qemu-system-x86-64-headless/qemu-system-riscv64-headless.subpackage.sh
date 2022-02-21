MCHS_SUBPKG_DESCRIPTION="A generic and open source machine emulator and virtualizer (headless)"
MCHS_SUBPKG_DEPENDS="glib, libbz2, libc++, libcurl, libgnutls, libiconv, libjpeg-turbo, liblzo, libnettle, libnfs, libpixman, libpng, libspice-server, libssh, libusb, libusbredir, ncurses, pulseaudio, qemu-common, resolv-conf, zlib, zstd"
MCHS_SUBPKG_DEPEND_ON_PARENT=no

MCHS_SUBPKG_INCLUDE="
bin/qemu-system-riscv64
share/man/man1/qemu-system-riscv64.1.gz
"

MCHS_PKG_HOMEPAGE=https://github.com/mchs/mchs-elf-cleaner
MCHS_PKG_DESCRIPTION="Cleaner of ELF files for Android"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
# NOTE: The mchs-elf-cleaner.cpp file is used by
#       scripts/build/mchs_step_start_build.sh
#       to create a native binary. Bumping this version will need
#       updating the checksum used there.
MCHS_PKG_VERSION=1.10
MCHS_PKG_SRCURL=https://github.com/mchs/mchs-elf-cleaner/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=b01a48bc6db85c66c683a2834608056ddc66f1964f7553810e8608aee3ee5648
MCHS_PKG_DEPENDS="libc++"
MCHS_PKG_BUILD_IN_SRC=true

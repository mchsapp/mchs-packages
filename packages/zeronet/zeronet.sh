#!@MCHS_PREFIX@/bin/bash
exec @MCHS_PREFIX@/opt/zeronet/zeronet.py \
	--config_file @MCHS_PREFIX@/etc/zeronet.conf \
	--data_dir @MCHS_PREFIX@/var/lib/zeronet \
	--log_dir @MCHS_PREFIX@/var/log/zeronet "$@"

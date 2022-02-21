mchs_step_install_service_scripts() {
	array_length=${#MCHS_PKG_SERVICE_SCRIPT[@]}
	if [ $array_length -eq 0 ]; then return; fi

	# MCHS_PKG_SERVICE_SCRIPT should have the structure =("daemon name" 'script to execute')
	if [ $(( $array_length & 1 )) -eq 1 ]; then
		mchs_error_exit "MCHS_PKG_SERVICE_SCRIPT has to be an array of even length"
	fi

	mkdir -p $MCHS_PREFIX/var/service
	cd $MCHS_PREFIX/var/service
	for ((i=0; i<${array_length}; i+=2)); do
		mkdir -p ${MCHS_PKG_SERVICE_SCRIPT[$i]}
		# We unlink ${MCHS_PKG_SERVICE_SCRIPT[$i]}/run if it exists to
		# allow it to be overwritten through MCHS_PKG_SERVICE_SCRIPT
		if [ -L "${MCHS_PKG_SERVICE_SCRIPT[$i]}/run" ]; then
			unlink "${MCHS_PKG_SERVICE_SCRIPT[$i]}/run"
		fi
		echo "#!$MCHS_PREFIX/bin/sh" > ${MCHS_PKG_SERVICE_SCRIPT[$i]}/run
		echo -e ${MCHS_PKG_SERVICE_SCRIPT[$((i + 1))]} >> ${MCHS_PKG_SERVICE_SCRIPT[$i]}/run

		# Do not add service script to CONFFILES if it already exists there
		if [[ $MCHS_PKG_CONFFILES != *${MCHS_PKG_SERVICE_SCRIPT[$i]}/run* ]]; then
			MCHS_PKG_CONFFILES+=" var/service/${MCHS_PKG_SERVICE_SCRIPT[$i]}/run"
		fi

		chmod +x ${MCHS_PKG_SERVICE_SCRIPT[$i]}/run

		# Avoid creating service/<service>/log/log/
		if [ "${MCHS_PKG_SERVICE_SCRIPT[$i]: -4}" != "/log" ]; then
			touch ${MCHS_PKG_SERVICE_SCRIPT[$i]}/down
			MCHS_PKG_CONFFILES+=" var/service/${MCHS_PKG_SERVICE_SCRIPT[$i]}/down"
			mkdir -p ${MCHS_PKG_SERVICE_SCRIPT[$i]}/log
			ln -sf $MCHS_PREFIX/share/mchs-services/svlogger ${MCHS_PKG_SERVICE_SCRIPT[$i]}/log/run

			MCHS_PKG_CONFFILES+="
			var/service/${MCHS_PKG_SERVICE_SCRIPT[$i]}/log/run
			var/service/${MCHS_PKG_SERVICE_SCRIPT[$i]}/log/down
			"
		fi
	done
}

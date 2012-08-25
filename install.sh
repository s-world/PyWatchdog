#!/bin/bash

install_script_dir=$(dirname $0)
pywatch_conf_path="/usr/local/etc/pywatchdog"

cp "${install_script_dir}/pywatchdog" /usr/local/sbin/
chmod o+x /usr/local/sbin/pywatchdog

if [ ! -d "${pywatch_conf_path}" ]; then
    mkdir -p "${pywatch_conf_path}"
fi

if [ ! -f "${pywatch_conf_path}/pywatchdog.conf" ]; then
    cp "${install_script_dir}/pywatchdog.conf" "${pywatch_conf_path}/pywatchdog.conf"
fi

cp "${install_script_dir}/pywatchdog-example.conf" "${pywatch_conf_path}/pywatchdog-example.conf"
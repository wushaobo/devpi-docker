#!/bin/bash

set -e

data_dir=/var/lib/devpi

echo $(htpasswd -nbs ${USER_NAME} ${PASSWORD}) > /etc/nginx/htpasswd
nginx -c /etc/nginx/nginx.conf

if [ ! -d "${data_dir}/.xproc" ]; then
    echo "Initializing devpi server"
    devpi-server --start --serverdir ${data_dir} --init --no-root-pypi --host 127.0.0.1

    devpi use http://127.0.0.1:3141
    devpi login root --password=''
    devpi user -m root password="${PASSWORD}"
    devpi user -c ${USER_NAME} password="${PASSWORD}"
    devpi logout

    devpi login ${USER_NAME} --password="${PASSWORD}"
    devpi index -y -c dev pypi_whitelist='*'
    devpi logout

    devpi-server --stop --serverdir ${data_dir}
fi

devpi-server --start --serverdir ${data_dir} --host 127.0.0.1 --outside-url ${OUTSIDE_URL}

tail -f ${data_dir}/.xproc/devpi-server/xprocess.log

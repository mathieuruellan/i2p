#!/bin/sh
#
# Author/Maintainer: konrad@getdiva.org
#
# Start i2pd
#
set -e

# optional - bind to the diva service backend (see /conf/tunnels.conf)
DIVA_IP=${DIVA_IP:-127.0.0.1}
# optional - bind to the iroha service backend (see /conf/tunnels.conf)
IROHA_IP=${IROHA_IP:-127.0.0.1}

# networking, use the docker upstream DNS 127.0.0.11 for global connectivity
echo "nameserver 127.0.1.1" > /etc/resolv.conf
/bin/cp -f /dnsmasq.conf /etc/dnsmasq.conf
dnsmasq -a 127.0.1.1 \
  --no-hosts \
  --local-service \
  --address=/diva.local/${DIVA_IP} \
  --address=/iroha.local/${IROHA_IP} \
  --server=127.0.0.11

# see configs: /conf/i2pd.conf
su i2pd -c "/home/i2pd/bin/i2pd-x86_64-aesni --datadir=/home/i2pd/data --conf=/home/i2pd/i2pd.conf"
#!/bin/bash

if ! wg show | grep -m 1 -q "${PROTONVPN_SERVER}"; then
  exit 1
fi

# Maintains port forwarding
if [ -f "/protonvpn-port/protonvpn-port" ]; then
  natpmpc -a 1 0 udp 60 -g 10.2.0.1 \
    && natpmpc -a 1 0 tcp 60 -g 10.2.0.1
  exit
fi

# Run port forwarding
# Write the port to /config/protonvpn-port
natpmpc -a 1 0 udp 60 -g 10.2.0.1 \
  && natpmpc -a 1 0 tcp 60 -g 10.2.0.1
  | grep -m 1 -oP 'public\ port\ \K\w+' > /protonvpn-port/protonvpn-port

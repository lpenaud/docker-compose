#!/bin/sh

# Check if all is ok
protonwire verify "${PROTONVPN_SERVER}" && \
  natpmpc -a 1 0 udp 60 -g 10.2.0.1 && \
  natpmpc -a 1 0 tcp 60 -g 10.2.0.1

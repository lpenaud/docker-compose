#!/bin/sh

protonwire connect --service &

# Wait to proton to be ok
until protonwire verify; do
  sleep 5
done

# Run port forwarding
# Write the port to /config/protonvpn-port
natpmpc -a 1 0 udp 60 -g 10.2.0.1 \
  && natpmpc -a 1 0 tcp 60 -g 10.2.0.1 \
  | grep -oP 'public\ port\ \K\w+' > /protonvpn-port/protonvpn-port

wait

#!/bin/bash

function test-port () {
  [[ "$(transmission-remote -ne -pt)" =~ Yes$ ]]
}

test-port && exit 0

transmission-remote -ne -p "$(cat /protonvpn-port/protonvpn-port)" && test-port

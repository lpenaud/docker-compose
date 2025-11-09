#!/bin/bash

function test-port () {
  transmission-remote -ne -pt
}

test-port && exit 0

transmission-remote -ne -p "$(cat /protonvpn-port/protonvpn-port)" && test-port

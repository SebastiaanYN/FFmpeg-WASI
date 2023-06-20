#!/bin/bash

set -euox pipefail

for f in ./scripts/deps/*.sh; do
  bash "$f" 
done

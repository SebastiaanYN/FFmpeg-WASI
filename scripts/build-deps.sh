#!/bin/bash

set -euo pipefail

for f in ./scripts/deps/*.sh; do
  bash "$f" 
done

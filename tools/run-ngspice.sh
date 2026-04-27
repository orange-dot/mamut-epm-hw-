#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 path/to/netlist.cir"
  exit 1
fi

netlist="$1"

if [[ ! -f "$netlist" ]]; then
  echo "Netlist not found: $netlist"
  exit 1
fi

netlist_abs="$(realpath "$netlist")"
netlist_dir="$(dirname "$netlist_abs")"
netlist_file="$(basename "$netlist_abs")"
base_name="${netlist_file%.cir}"
log_file="${base_name}.log"

cd "$netlist_dir"

echo "Running ngspice:"
echo "  netlist: $netlist_abs"
echo "  workdir: $netlist_dir"
echo "  log:     $netlist_dir/$log_file"
echo

ngspice -b -o "$log_file" "$netlist_file"

echo
echo "Done."

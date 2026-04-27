#!/usr/bin/env bash
set -euo pipefail

core_tools=(
  git
  python3
  pip
  kicad
  kicad-cli
  ngspice
  gnuplot
)

optional_tools=(
  qucs-s
  Xyce
)

missing_core=0

print_version() {
  local cmd="$1"

  case "$cmd" in
    kicad)
      "$cmd" --version 2>/dev/null | head -n 1 || true
      ;;
    kicad-cli)
      "$cmd" version 2>/dev/null | head -n 1 || true
      ;;
    ngspice)
      "$cmd" -v 2>/dev/null | head -n 1 || true
      ;;
    gnuplot)
      "$cmd" --version 2>/dev/null | head -n 1 || true
      ;;
    qucs-s)
      "$cmd" --version 2>/dev/null | head -n 1 || true
      ;;
    Xyce)
      "$cmd" -v 2>/dev/null | head -n 1 || true
      ;;
    python3)
      "$cmd" --version 2>/dev/null | head -n 1 || true
      ;;
    pip)
      "$cmd" --version 2>/dev/null | head -n 1 || true
      ;;
    git)
      "$cmd" --version 2>/dev/null | head -n 1 || true
      ;;
    *)
      "$cmd" --version 2>/dev/null | head -n 1 || true
      ;;
  esac
}

echo "Mamut environment check"
echo

if [[ -f /etc/os-release ]]; then
  . /etc/os-release
  echo "Host: ${PRETTY_NAME:-unknown}"
fi
echo "Kernel: $(uname -r)"
echo

echo "Core tools:"
for cmd in "${core_tools[@]}"; do
  if command -v "$cmd" >/dev/null 2>&1; then
    printf "  [ok] %s -> %s\n" "$cmd" "$(command -v "$cmd")"
    ver="$(print_version "$cmd")"
    if [[ -n "$ver" ]]; then
      printf "       %s\n" "$ver"
    fi
  else
    printf "  [missing] %s\n" "$cmd"
    missing_core=1
  fi
done

echo
echo "Optional tools:"
for cmd in "${optional_tools[@]}"; do
  if command -v "$cmd" >/dev/null 2>&1; then
    printf "  [ok] %s -> %s\n" "$cmd" "$(command -v "$cmd")"
    ver="$(print_version "$cmd")"
    if [[ -n "$ver" ]]; then
      printf "       %s\n" "$ver"
    fi
  else
    printf "  [optional-missing] %s\n" "$cmd"
  fi
done

echo
if [[ "$missing_core" -eq 0 ]]; then
  echo "Environment looks ready for KiCad/ngspice work."
else
  echo "Core tools are missing."
  echo "Run ./tools/bootstrap-fedora.sh on Fedora to install the default stack."
  exit 1
fi

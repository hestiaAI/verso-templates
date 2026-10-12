#!/bin/sh
set -eu

cd "$(dirname "$0")"
export PATH="$HOME/.elan/bin:$PATH"

if ! command -v elan >/dev/null 2>&1; then
    installer=$(mktemp)
    trap 'rm -f "$installer"' EXIT HUP INT TERM
    curl --proto '=https' --tlsv1.2 -fsSL \
        https://raw.githubusercontent.com/leanprover/elan/v4.1.2/elan-init.sh \
        -o "$installer"
    sh "$installer" -y --default-toolchain none
fi

elan run --install "$(tr -d '\r\n' < lean-toolchain)" lean --version
lake exe generate-website "$@"
python3 check_site.py
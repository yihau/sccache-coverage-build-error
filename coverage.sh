#!/usr/bin/env bash

set -ex

# install sccache if needed
if ! command -v sccache &> /dev/null
then
  cargo install sccache
fi
export RUSTC_WRAPPER=$(which sccache)

# https://github.com/mozilla/grcov#example-how-to-generate-gcda-files-for-a-rust-project
export CARGO_INCREMENTAL=0
export RUSTFLAGS="-Zprofile -Ccodegen-units=1 -Copt-level=0 -Clink-dead-code -Coverflow-checks=off -Zpanic_abort_tests -Cpanic=abort"
export RUSTDOCFLAGS="-Cpanic=abort"

# nightly-2023-02-08 ✅
rustup toolchain install nightly-2023-02-08
cargo +nightly-2023-02-08 test

# nightly-2023-02-09 ❌
rustup toolchain install nightly-2023-02-09
cargo +nightly-2023-02-09 test
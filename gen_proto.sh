#!/usr/bin/env bash

set -eou pipefail

namespace=pysubstrait
submodule_dir=./third_party/substrait
src_dir="$submodule_dir"/proto
tmp_dir=./proto
dest_dir=./src/substrait/proto

python "$submodule_dir"/tools/proto_prefix.py "$tmp_dir" "$namespace" "$src_dir"

rm -rf "$dest_dir"

buf generate
protol --in-place --create-package --python-out "$dest_dir" buf

rm -rf "$tmp_dir"

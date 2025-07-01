#!/usr/bin/env bash

OUTDIR="./data"
mkdir -p "$OUTDIR"

CUR_DIR=$(pwd)

set -eu

cd $OUTDIR
../download-srtm-data.sh
../create-tiles.sh SRTM_NE_250m.tif 10 10
../create-tiles.sh SRTM_SE_250m.tif 10 10
../create-tiles.sh SRTM_W_250m.tif 10 20
rm -rf SRTM_NE_250m.tif SRTM_SE_250m.tif SRTM_W_250m.tif *.rar

cd $CUR_DIR

#!/bin/bash

declare -a urls=(

# Rom URLs
'https://hugeota.d.miui.com/20.9.24/miui_CMI_20.9.24_b8d7c72247_11.0.zip'

)

EU_VER=20.9.24

declare -a eu_urls=(
'https://phoenixnap.dl.sourceforge.net/project/xiaomi-eu-multilang-miui-roms/xiaomi.eu/MIUI-WEEKLY-RELEASES/20.9.24/xiaomi.eu_multi_MI10Pro_20.9.24_v12-11.zip'
)


command -v dirname >/dev/null 2>&1 && cd "$(dirname "$0")"
if [[ "$1" == "rom" ]]; then
    set -e
    base_dir=/sdcard/TWRP
    [ -z "$2" ] && VER="$EU_VER" || VER=$2
    [ -d "$base_dir" ] || base_dir=.
    aria2c_opts="--check-certificate=false --file-allocation=trunc -s10 -x10 -j10 -c"
    aria2c="aria2c $aria2c_opts -d $base_dir/$VER"
    for i in "${eu_urls[@]}"
    do
        $aria2c ${i//$EU_VER/$VER}
    done
    base_url="https://github.com/Aoangc/mipay-extract/releases/download/$VER"
    $aria2c $base_url/eufix-CMI-$VER.zip
    $aria2c $base_url/mipay-CMI-$VER.zip
    $aria2c $base_url/eufix-appvault-CMI-$VER.zip
    exit 0
fi
# for i in "${urls[@]}"
# do
#    bash extract.sh --appvault "$i" || exit 1
# done
# [[ "$1" == "keep"  ]] || rm -rf miui-*/ miui_*.zip
# for i in "${eu_urls[@]}"
# do
#    bash cleaner-fix.sh --nofbe "$i" || exit 1
# done
bash start.sh
exit 0

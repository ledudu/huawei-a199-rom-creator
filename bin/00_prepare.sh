#!/bin/bash

__script_dir=$(dirname $0)
__root_dir=$(dirname $__script_dir)
source $__script_dir/common

pushd $__root_dir >/dev/null 2>&1

if prepared; then
    echo "already prepared, doing nothing."
    exit 0
fi

echo "clearing $__work_dir and $__rom_dir ..."
rm -rf $__work_dir
mkdir -pv $__work_dir

rm -rf $__rom_dir
mkdir -pv $__rom_dir

app_file=${1:-UPDATE.APP}

if [ ! -e "$app_file" ]; then
    echo "$app_file does not exist."
    exit 1
fi

echo "unpacking $app_file ..."
$__script_dir/split_updata.py -u $app_file

echo "mounting work/system/ ..."
mkdir -pv $__work_dir/system
sudo mount -o loop $__output_dir/system.img $__work_dir/system

echo "mouting work/cust/..."
mkdir -pv $__work_dir/cust
sudo mount -o loop $__output_dir/cust.img $__work_dir/cust

echo "mouting work/userdata/..."
mkdir -pv $__work_dir/userdata
sudo simg2img $__output_dir/userdata.img $__output_dir/userdata.ext4
sudo mount -o loop $__output_dir/userdata.ext4 $__work_dir/userdata

cp -v $__output_dir/boot.img $__rom_dir/boot.img
cp -v $__output_dir/recovery.img $__rom_dir/recovery.img

popd $__root_dir >/dev/null 2>&1

# vim:ai:et:sts=4:sw=4:

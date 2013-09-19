#!/bin/bash

__script_dir=$(dirname $0)
__root_dir=$(dirname $__script_dir)

pushd $__root_dir >/dev/null 2>&1

__work_dir=$__root_dir/work
__rom_dir=$__root_dir/rom
__output_dir=$__root_dir/output

gapps_zip="gapps-jb-20121011-signed.zip"

if [ ! -e "$gapps_zip" ]; then
    echo "please download $gapps_zip and put it in this dir."
    exit 1
fi

excludes=( ${excludes[@]} 'system/tts/*' )
excludes=( ${excludes[@]} 'optional/*' )
excludes=( ${excludes[@]} 'META-INF/*' )
excludes=( ${excludes[@]} 'install-optional.sh' )
excludes=( "system/app/GenieWidget.apk" )                   # weather and news
excludes=( ${excludes[@]} system/app/GoogleFeedback.apk )
excludes=( ${excludes[@]} system/app/MediaUploader.apk )    # Picasa Uploader
excludes=( ${excludes[@]} system/app/GoogleEars.apk )       # Sound Search for Google Play
# include system/app/Thinkfree.apk         # Document Viewer v4.2.120504
# include system/app/Phonesky.apk          # Google Play Store v3.9.16
# ?       system/app/Microbes.apk          # Microbes Live Wallpaper

pushd $__work_dir >/dev/null 2>&1
sudo unzip ../$gapps_zip -x ${excludes[@]}
popd >/dev/null 2>&1

# vim:ai:et:sts=4:sw=4:

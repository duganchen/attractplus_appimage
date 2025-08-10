#!/usr/bin/env bash

set -e

apt update
apt-get -y upgrade
apt install -y wget build-essential pkg-config cmake libavformat-dev libswscale-dev libgl-dev libxrandr-dev \
    libxcursor-dev libxi-dev libudev-dev libfreetype-dev libvorbis-dev libflac-dev libexpat1-dev libglu1-mesa-dev \
    libopenal-dev libboost-filesystem-dev file

rm -rf /attractplus_appimage/work
mkdir /attractplus_appimage/work
cd /attractplus_appimage/work
wget --content-disposition https://github.com/oomek/attractplus/archive/refs/tags/3.1.2.tar.gz
tar xf attractplus-3.1.2.tar.gz
cd attractplus-3.1.2
mkdir -p /attractplus_appimage/work/attractplus.AppDir/usr/share/{applications,pixmaps}
make prefix=/usr DATA_PATH=../share FE_HWACCEL_VAAPI=1 FE_HWACCEL_VDPAU=1
make prefix=/attractplus_appimage/work/attractplus.AppDir/usr install
cp -v util/icon.png /attractplus_appimage/work/attractplus.AppDir/usr/share/pixmaps/attractplus.png
cp -v /attractplus_appimage/attractplus.desktop \
    /attractplus_appimage/work/attractplus.AppDir/usr/share/applications/attractplus.desktop

# I couldn't get these intro videos to play, but I'm going through the motions anyway.

wget -O /attractplus_appimage/work/attractplus.AppDir/usr/share/attractplus/intro/intro.mp4 \
    https://github.com/mickelson/attract/releases/download/v1.6.2/ATTRACT.MODE.intro.16-9.v6.1080p.mp4

wget -O /attractplus_appimage/work/attractplus.AppDir/usr/share/attractplus/intro/intro_4x3.mp4 \
    https://github.com/mickelson/attract/releases/download/v1.6.2/ATTRACT.MODE.intro.4-3.v6.1080p.mp4

# And now we build the AppImage
cp /attractplus_appimage/AppRun /attractplus_appimage/work/attractplus.AppDir
cd /attractplus_appimage/work
wget -O linuxdeploy https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
chmod +x linuxdeploy
./linuxdeploy  --appimage-extract-and-run --appdir attractplus.AppDir --output appimage

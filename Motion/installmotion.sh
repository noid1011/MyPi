#!/bin/bash

sudo apt-get -y install git
sudo apt-get install dh-autoreconf

sudo apt-get remove x264, libx264-dev, libavcodec, libavcodec, libavfilter, libavfilter, libavresample, libavutil, libpostproc, libswresample, libswscale, ffmpeg
cd ~

git clone git://git.videolan.org/x264.git
cd x264
./configure --enable-shared --disable-opencl
make
sudo make install 
sudo ldconfig
cd ~

git clone git://source.ffmpeg.org/ffmpeg.git
cd ffmpeg
./configure --arch=armhf --target-os=linux --enable-gpl --enable-libx264 --enable-nonfree --enable-shared
make
sudo make install 
sudo ldconfig
cd ~

git clone https://github.com/Mr-Dave/motion.git
cd motion
autoreconf -fiv
./configure
make
sudo make install 
sudo ldconfig 
cd ~

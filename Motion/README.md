
Building Motion with ffmpeg and RTSP support


Note: If you want something similar to ZoneMinder, there is a web UI for Motion called MotionEye written in python and if you don’t care about the installed linux distribution, then you can flash an SD card with MotionPie.


Build steps:

    Clean & purge old packages

    Remove every package from the following list: x264, libx264-dev, libavcodec, libavcodec, libavfilter, libavfilter, libavresample, libavutil, libpostproc, libswresample, libswscale, ffmpeg.

    You can search them with:
    dpkg -S

    and then remove them (with –purge if necessary):
    sudo apt-get remove

    Make sure that none of the above libraries are left in the linker’s path. Search them again with:
    ldconfig -p | grep
    Build & install libx264

    git clone git://git.videolan.org/x264.git
    cd x264
    ./configure --enable-shared --disable-opencl
    make
    sudo make install && ldconfig
    Build & install ffmpeg with x264 support

    git clone git://source.ffmpeg.org/ffmpeg.git
    cd ffmpeg
    ./configure --arch=armhf --target-os=linux --enable-gpl --enable-libx264 --enable-nonfree --enable-shared
    make
    sudo make install && ldconfig
    Build & install Mr-dave’s Motion fork

    git clone https://github.com/Mr-Dave/motion.git
    cd motion
    ./configure
    make
    sudo make install && ldconfig 

Testing Motion with an IP camera:

Before running motion, test your camera’s RTSP stream with a normal video player. In VLC that would be Media->Open Network Stream(Ctrl+N) and enter your RTSP url.

If you get a live stream then you can make a copy of motion-dist.conf(found in /usr/local/etc/motion), name it motion.conf and change the options to suite your needs.

I’ve commented out the default video device:
;videodevice /dev/video0

and then uncommented and set the values for netcam_url and netcam_userpass like so:
netcam_url rtsp://192.168.1.10:554/user=admin&password=&channel=1&stream=0.sdp?
netcam_userpass admin:

Start motion in setup mode to test your configuration:
motion -s
and wave your hand in front of the camera.You should have motion-triggered snapshot and video sequences in your target_folder.

Now you can catch the bad guys !


Building Motion with ffmpeg and RTSP support

When it comes to video surveillance, your options on Linux are quite limited. The only ones worth mentioning are ZoneMinder and Motion. I picked Motion because:

    ZoneMinder is big/has a lot of perl modules as dependencies. When I think about perl I can only imagine pre-PHP web programming or shady people maintaining it.
    Motion is written in C and configured via config files.
    My IP camera(CCTVEX EX-S06WM) streams video with RTSP(Real Time Streaming Protocol) and is configured via a web interface which requires an ActiveX plugin(Windows Only) or via ONVIF compliant software. ZoneMinder has some ONVIF support, but I configured my camera on a virtual machine and used it with Motion.
    Acording to a user on Raspbian forum, Zoneminder stores the video events snapshot by snapshot which is not very good for a lowcost surveillance system involving a single core Raspberry Pi, a cheap IP Camera and an 80 GB HDD.I might be wrong here…
    Motion can store(with ffmpeg) the motion-triggered h264 encoded movie sequence in *.avi containers.
    Zonminder build failed on my PC so I didn’t bother to try it on Raspberry Pi. It may provide more features,but I want to make my own web interface so most of it would be unused.
    I think I might save some resources by using the less complex solution.
    Motion built fine on my PC but initially failed on Raspberry Pi.Several days later, it finally worked.

Note: If you want something similar to ZoneMinder, there is a web UI for Motion called MotionEye written in python and if you don’t care about the installed linux distribution, then you can flash an SD card with MotionPie.

I tried to build Motion on Raspberry Pi with packages from the Raspbian repository but I got some linker errors such as:

Linking Motion...
...
/usr/local/lib/libavcodec.a(libx264.o): In function `X264_frame':
/mnt/hdata/soft/ffmpeg/libavcodec/libx264.c:169: undefined reference to `x264_picture_init'
...
/usr/local/lib/libavcodec.a(opusdec.o): In function `opus_decode_subpacket':
/mnt/hdata/soft/ffmpeg/libavcodec/opusdec.c:374: undefined reference to `swr_is_initialized'
...

So I had to remove everything related to ffmpeg/libav and x264 and then rebuild them from sources. I wanted the mysql data logging, timelapse and h264 encoded video sequences provided by Motion. I’ve also picked Mr-Dave’s fork because its RTSP support seems to be ahead of the main branch, judging by a diff on netcam_rtsp.h …

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

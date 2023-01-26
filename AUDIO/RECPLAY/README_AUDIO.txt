
// update 8/27/22

                AUDIO interface

updated again 8/27/22

kernel 5.19.4


N.B.  web browser may lock out /dev/snd


Scripts used to interact with /dev/dsp  back in linux 2.x days.
How to update and resurrect the audio play and record features so we can create some
programs to do audio compression, noise removal, speech and music recognition.

Want to use the ALSA driver modules but first there was option to build old snd drivers
for the 3.x kernel



Configure kernel for snd drives -- included oss (I think)
produced
Linux neptune.rootmeansquare.com 5.19.4 #2 SMP PREEMPT_DYNAMIC Thu Aug 25 18:16:12 MDT 2022 x86_64 x86_64 x86_64 GNU/Linux


then needed to install snd-pcm-oss via mod probe
sudo modprobe snd-pcm-oss

After which I could see the /dev/dsp device.
may need to make these devices +rw for all


[mark@mars ~]$ ls -l /dev/audio
crw-rw----+ 1 root audio 14, 4 Jun  1 19:32 /dev/audio
[mark@mars ~]$ ls -l /dev/dsp
crw-rw----+ 1 root audio 14, 3 Jun  1 19:32 /dev/dsp

 ls -l /dev/snd
total 0
drwxr-xr-x. 2 root root       60 May 31 14:18 by-path
crw-rw----+ 1 root audio 116,  7 May 31 14:18 controlC0
crw-rw----+ 1 root audio 116,  6 May 31 14:18 hwC0D0
crw-rw----+ 1 root audio 116,  5 May 31 14:18 hwC0D3
crw-rw----+ 1 root audio 116,  4 Jun  1 08:58 pcmC0D0c
crw-rw----+ 1 root audio 116,  3 Jun  1 19:36 pcmC0D0p
crw-rw----+ 1 root audio 116,  2 May 31 14:19 pcmC0D3p
crw-rw----+ 1 root audio 116,  1 May 31 14:18 seq
crw-rw----+ 1 root audio 116, 33 May 31 14:18 timer

after this my old audio interface that talked with /dev/dsp /dev/mixer via ioctl calls worked.

 So the calls would open devices and play a linear pcm sound file

   dspfd = dspopen() // get/open dsp

   mixfd = mixeropen() // get/open  mixer

   PlayFile(sf,dspfd,mixfd, bytesize/2, Freq, gain, nchans)

and the splay script would work

asl splay.asl -g 20 -f 16000 ../SIGNALS/ec2.0-10.vox 
 na 6 
 setting gain 20.000000  
 setting sf 20 
5 setting Freq 16000  
 setting sf ../SIGNALS/ec2.0-10.vox 
 play file is ../SIGNALS/ec2.0-10.vox 
bytesize 328192 
 dspfd 4 mixfd 5 
 20.000000 1 
mixer_read_vol 5f5f
mixer_write_mic 0
SB16 1010
mixer_read_igain 1010
mixer_read_ogain 1010
mixer_pcm_read_bits 8
channels 1 rparm 1 
freq 16000 rparm 16000 

 Next try recording.

 recording works

 control of mic gain does not.


 also need to fix gain in splay



 Using web browser locks up the /dev/dsp devices?

 move recording play back to ALSA - whatever the modern sound controllers are using.
 


  updated splay.asl audio.asl
for newer  procedure calls  ( i.e cpp compatible)

 have to check record  - mic gain mixer SF etc


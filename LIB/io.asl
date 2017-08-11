#! asl
#/* -*- c -*- */
# "$Id: io.g,v 1.2 2000/04/17 03:39:34 mark Exp mark $"

  if (Main_init) {

# Globals init only once if reloading script modules during debug

# signal space required
    Show_sp = 1
    Use_buffer = 0
    Voxf = "demo.vox"
    Z0 = 0.0
    Z1 = 1.0
    Sfwav = Sfpcm = 16000.0
# get signal space
    sec_ss = Sfwav * 1

    ss= get_signal_space(sec_ss)

      if ( ss == -1) {
        << "can't get enough signal space"
        exit_si()
      }

    float Da_res;
    Da_res = 32767.0
    if ( CheckGwm())
    Da_res = read_devices()

    Tw_y = -Da_res
    Tan = -Da_res

    The_extn = "pcm"
    subdir = ""
    Max_dur = 10.0

      //<<" %v $Max_dur \n"


    EndBuffer = 1.0
    NEG_READ = -2
    NEG_WRITE = -3
    NEG_EXE = -4
    NEG_DIR = -5
    Wchan = 0
# wo regions for display of multi-channel signals
# only one window for now - do a 2 dim array later
    NC =2

    int MCW[32+]

    MCW[0] = -1

  }

proc read_wav(sbn,wavf)
{
  dur =   fstart = 0.0
  asc = 1.0
  swabit = 0
  mmr = 0.75
  success = read_signal(sbn,wavf,0.0,dur,fstart,mmr,0,asc,1024,Sfwav,"short",swabit)
  return (success)
}


proc read_pcm(sbn,file)
{

  dur =   fstart = 0.0
  asc = 1.0
  swabit = 0
  mmr = 0.75
  success = read_signal(sbn,file,0.0,dur,fstart,mmr,0,asc,0,Sfpcm,"short",swabit)
  return (success)
}


proc vox_from_sig(sigf)
{
  stem = spat(sigf,".",-1,-1)
  voxf = scat(stem,".vox")
  voxsz = f_exist(voxf)

<<" $stem $voxf $voxsz $(typeof(voxf)) \n"

    if (voxsz <= 0) {
      :vf = spat(voxf,"/",1,-1)
      voxf = scat(Play_dir,"/SPD/",vf)
      voxsz = f_exist(voxf)
    }

  return (voxf)
 }

proc check_sf(wn)
{
  float sf = GetSF(wn)
  if (sf <= 0.0) sf = Sfpcm
    return sf
}

proc read_the_signal (sbn,sigf,fstart,dur,read_it)
{
  LPaint = 1
  twls = twlf = -1.0

   sf=get_sigb_freq(sbn)

    if (read_it) {

        if (Use_buffer) {
          success=read_to_win_buffer(sbn,sigf,fstart,dur)
        }
        else {
          success=read_signal_file(sbn,sigf,fstart,dur)
          n_dur = success/sf
        }
    }
    else {
      n_dur = dur
      success = dur * sf
      Z0 = fstart
      Z1 = fstart +n_dur
    }

<<" %v $Use_buffer \n"

    if (Use_buffer) {
      stem = spat(sigf,".",-1,-1)
      voxf = scat(stem,".vox")
      Voxf = voxf
      display_buffer(tw,Max_dur)
    }
    else {

      voxf = vox_from_sig(sigf)

<<" %v $voxf \n"

#      display_vox(voxf,fstart,fstart + n_dur,Max_dur,tw)
       fend = fstart + n_dur
      display_vox(voxf,fstart,fend,Max_dur,tw)
    }

  Stp = get_channel_para(voxf,"STP")
  noc = get_channel_para(voxf,"NOC")
  Endtime = Stp
  EndBuffer = Stp
  <<"Endtime= STP $Stp $sf $noc \n"

  f=w_store(tw)
  return (success)
}


proc read_signal_file(sbn,sigf,fstart,dur)
{

# use relative path
  sf=get_sigb_freq(sbn)
  //  sf = check_sf(tw)
  nc = 1

  lsigf = spat(sigf,"/",1,-1)

  if (lsigf @= "")       lsigf = sigf

  stem = spat(lsigf,".",-1,-1)
  ext = spat(lsigf,".",1,-1)

# assume or make vox header

  voxf = scat(stem,".vox")

  voxsz = f_exist(voxf)
  << "voxf $voxf  %v $voxsz\n"
    if (voxsz <= 0) {
      voxf = scat(Play_dir,"/SPD/",voxf)
      voxsz = f_exist(voxf)
    }

    if (voxsz <= 0) {
        if (ext @= "pcm") {
              sv = spat(lsigf,"stereo",1,-1)
                if (! (sv @= "")) {
                  <<"stereo file \n"
                  nc = 2
                }
              <"addh -i $lsigf -o $voxf  -f $sf -n $nc "
        }

       if (ext @= "wav") 
                 <"addh -i $lsigf -o $voxf -O 1024 -f $Sfwav "

      sz=fe(voxf)
        if (sz <=0) {
          voxf = vox_from_sig(sigf)
          <"addh -i $sigf -o $voxf -f $sf  -n $nc"
        }
    }

  Voxf = voxf

  Stp = get_channel_para(voxf,"STP")
  noc = get_channel_para(voxf,"NOC")
  Endtime = Stp
  EndBuffer = Stp

  <<"Endtime= STP $Stp $sf $noc \n"

  nsamps = Stp * sf

  Z0 = 0
  Z1 = Endtime
  return nsamps
}

proc read_to_win_buffer(sbn,sigf,fstart,dur)
{

# how much of DA range to scale to
  mmr = 0.75
# autoscale to desired min-max range
  asc = 1
  sf=get_sigb_freq(sbn)
    //  sf =check_sf(tw)
    //  Clear_buf(tw)
  swabit = 0

    if (Myname @= "HAL") swabit = 1


# is it a vox_file, .wav, .pcm ?

  voxf = spat(sigf,".",1,-1)

    if (voxf @= "wav") 
      success = read_signal(sbn,sigf,0.0,dur,fstart,mmr,0,asc,1024,sf,"short",swabit)
    else if (voxf @= "vox") 
      success = read_signal(sbn,sigf,0.0,dur,fstart,mmr,0,asc)
    else if (voxf @= "pcm") 
      success = read_signal(sbn,sigf,0.0,dur,fstart,mmr,0,asc,0,sf,"short",swabit)

  write_signal(sbn,"work/tmp.vox",0)

  n_dur = success/ sf
  Endtime = n_dur
  Z0 = 0.0
  Z1 = Endtime
<< " %v $Endtime \n"
  return success
}


proc display_buffer(tw,max_dur)
{
  LPaint = 1
  w_clearclip(tw)
  setpen(tw,"blue",1)
  dur = Z1-Z0
    if (dur < max_dur) z2 = Z1
    else 
      z2 = Z0 + max_dur
    
  w_SetRS(tw,Z0,Tw_y,z2,Da_res)
  ff=draw_signal(tw)
  scale_taw(tw,1)
  set_sr_times(tw,Z0,Z1)
  ff=w_storeb(tw)
}


proc display_vox(voxf,vt1,vt2,max_dur,tw)
{
  LPaint = 1
  ff=w_clearclip(tw)
  setpen(tw,"blue",1)

  dur = vt2-vt1

    if (dur < max_dur) 
      z2 = vt2
    else 
      z2 = vt1 + max_dur

  w_SetRS(tw,0,vt1)
  w_SetRS(tw,2,z2)

  NC = 1

   res =get_df_para(voxf,"NOC")

    if (res @= "NOT_FOUND") 
      NC = 1
    else 
      NC = res

     vnc = NC

 << "$voxf $tw $z2 $max_dur nc $NC $Wchan\n"

    if (vnc == 1) {
      <<"there is one channel $tw $voxf $vnc $vt1 $z2 Wchan $Wchan\n"
      ff=view_mcsignal(tw,voxf,vt1,z2,Wchan)
    }
    else {
      <<"%v$NC %v$vnc \n"
        if (NC == 1) 
        ff=view_mcsignal(tw,voxf,vt1,z2,Wchan)
        else {
# need array of wos
          set_up_wo_mc(tw,NC,vt1,z2)
          ff=view_mcsignal(tw,voxf,vt1,z2,-1, &MCW[0])
        }
    }

  scale_taw(tw,1)
  ff=w_storeb(tw)
}


proc get_the_file(extn,tag)
{
  f_ok = 0
  get_file = 1
# list of  files in dir
  show_curs(1,-1,-1,"cross")

    while (get_file) {
      subdir =""
      timit_file=GetMem(tag)

      fldir = get_dir()
      << "dir is $fldir %v$timit_file\n"

      timit_file = navi_w("VOX_File","wav file?",timit_file,extn,fldir)

      <<" $timit_file \n"

	//        if ( (timit_file @= "") || (timit_file == 0) || (timit_file @= "0") ) {
	if ( timit_file @= ""  ) {
          <<"$cproc null file"
          return (0)
        }

      kl = slen(timit_file)
      The_extn = spat(timit_file,".",">","<")

      PutMem(tag,timit_file)
      subdir = spat(timit_file,"/",-1,-1)
      << "extn $The_extn $subdir\n"
      sig_file = timit_file
      timit_file = spat(timit_file,The_extn)
      timit_file = spat(timit_file,".","<","<")
      sz = fe(sig_file)

      << "$sig_file size $sz \n"

        if (sz > 0) {
          get_file = 0
          f_ok = 1
        }
        else {
          commentary(" file permission error?")
          file_perror(sz)
        }
    << " get_file $get_file $f_ok\n"
    }
  return (f_ok)
}


proc file_perror(err)
{

    if (err == NEG_READ) 
      op = decision_w("File_Error","can't read this file: permissions -not owner? " ," OK " )
    else if (err == NEG_WRITE) 
      op = decision_w("File_Error","can't write this file: permissions " ," OK " )
    else if (err == NEG_EXE) 
      op = decision_w("File_Error","can't execute this file: permissions " ," OK " )
    else if (err == NEG_DIR) 
      op = decision_w("File_Error","can't search this directory : permissions " ," OK " )
}


proc set_up_wo_mc(tw,nc,t1,t2)
{

# for this time window setup MC wo channel display regions
# get clip region and subdivide

  dyc = 0.25
  x0 = 0.1
  x1 = 0.9
  y0 = 0.2
  y1 = y0 + dyc
<<"$cproc %v$nc \n"
    for (k = 0 ; k < nc ; k++) {
        if (MCW[k] <= 0) {
          MCW[k]=w_set_wo(tw,WBV," chn$k ",1,x0,y0,x1,y1,"")
          print("WOC $k woc ",MCW[k],"\n")
# use tw current scales
          ff=wo_setrs(tw,MCW[k],t1,-32000,t2,32000)
        }
        else {
# should be set up
          ff=wo_setrs(tw,MCW[k],t1,-32000,t2,32000)
        }
      y0 = y1
      y1 += dyc
    }
}




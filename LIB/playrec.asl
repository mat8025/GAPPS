#/* -*- c -*- */
# "$Id: playrec.g,v 1.2 2000/02/01 03:53:11 mark Exp mark $"
# playrec library functions

  if (Main_init) {
<< "init playrec.g \n"
    Loud = 1
    Olds1 = Olds2 = 0
    SUN_BO = 1
    INTEL_BO = MASSCOMP_BO = 0

    gsplay = gev("GS_PLAY")
    gsrec  = gev("GS_REC")

    << "$gsplay $gsrec $Display\n"

      if (Display @= "") 
        Wplay = Wrec = Myname
      else 
        Wrec = Wplay = Display

    << "Display $Display  RecordON $Wrec PlayON $Wplay \n"

    USER = gev("USER")

      if (USER @= "") USER = gev("LOGNAME")

      if ( ! (gsplay @= ""))         Wplay = gsplay
      if ( ! (gsrec @= ""))         Wrec = gsrec

    Play_dir = gev("GS_HOME")

    if (Play_dir @= "") {

    << "GS_HOME can't read env \n "

    gs_home_dir = get_gs_home()

    << "GS_HOME set $gs_home_dir \n"

    Play_dir = "${gs_home_dir}/WORK"
    }
    else 
    Play_dir = "${Play_dir}/.GASP/WORK"

    << " Play_dir $Play_dir \n"

    tmp_wav = "${Play_dir}/tmp_wav"
    tmp_vox = "${Play_dir}/tmp_vox" 
    voxtmp = "${Play_dir}/voxtmp" 
    tvox = "${Play_dir}/tmp.vox"

    rcp_tmp_vox = scat(Wplay,":",tmp_vox)
    sunpcm = scat(Play_dir,"/sunpcm")
    sunau = scat(Play_dir,"/sun.au")
# Wplay BO?
   Wp_machine = get_arch()
# this hangs up on Linux machine if Wplay is the local machine
# Sun volume on audio play (1-100)
   Svol = 80
   Play_freq = 16000
  << " done playrec init \n"
 }

proc play_intel(bn,s1,s2)
{
  nsw=write_signal(bn,tmp_vox,s1,s2,0,0)
  commentary("Playing via /dev/dsp0 $nsw $tmp_vox ")
  <"sb_play -i $tmp_vox -W  &"
  <"chmod 666 $tmp_vox"
}


proc play_sun_audio (sw,s1,s2)
{

# if a sun machine using the audio chip
#  wo_setvalue(sw,status_wo,"playing via sun audioplay")
  write_buffer(sw,"tmpv",s1,s2)
  ff=command("chmod 666 tmpv")

  command("audioconvert -o ",sunau,"-f sun -F -i linear16,rate=16k,mono ",tmpv)
  
  command("audioplay -v ",Svol,"  ",sunau, "&")

#  command("voxauplay  tmpv ",Svol)
# voxauplay
#audioconvert -o tmp.au -f sun -F -i linear16,rate=16k,mono $1
#audioplay tmp.au

  ff=wo_setvalue(sw,status_wo," ")
}


proc play_masscomp(sw,s1,s2)
{
  the_sf = check_sf(sw)
  sword = scat("playing via vp_me109 ",the_sf)
  ff=wo_setvalue(sw,status_wo,sword)
  ff=write_signal(sw,"/tmp/me109B.vox",s1,s2,0,1)
  command("vp_me109 /tmp/me109B.vox")
  ff=wo_setvalue(sw,status_wo," ")
}


proc play_remote_intel(sw,s1,s2)
{
  sword = scat("playing via ",Wplay)
#  ff=wo_setvalue(sw,status_wo,sword)
  ff=write_signal(sw,tmp_vox,s1,s2,0,0)
  ff=command("chmod 666 ",tmp_vox)

  <"rcp $tmp_vox $rcp_tmp_vox"
  <"rsh $Wplay  sb_play -i $tmp_vox"
  ff=wo_setvalue(sw,status_wo," ")
  return
}

proc play_sr (sw)
{
      s=GetSR(sw)
	//      bn = s[3] // get GetSR to return this
      play_the_signal (s[3],s[1],s[2])
}

proc play_window (sw)
{
#name_debug("EXP","ARGS","VAR","SI","FUNC",0)
      the_sf = check_sf(sw)
      rs=w_GetRS(sw)
      :s1= rs[1] * the_sf
      :s2 = rs[3] * the_sf

     if ( ! Use_buffer) {
<< " $s1 $s2  $the_sf\n"
      t2 = s2/the_sf
      t1 = s1/the_sf
      play_vox(Voxf,t1,t2,the_sf)
      return 1
     }

      bn = get_wbuf_nu(sw)

      <<"$cproc $bn  $s1 $s2 sf $the_sf \n"

      play_the_signal (bn,s1,s2)

}

proc play_buffer (bn)
{
      the_sf = get_sigb_freq(bn)
      s1= 0
      s2 = get_sigb_end(bn) * the_sf
      <<"$cproc $bn buffer $s2 $the_sf \n"
      play_the_signal (bn,s1,s2)
}


proc play_vfile (sw, float t1, float t2)
{
         sf = check_sf(sw)
<<" $cproc $sf $t1 $t2 \n"
         play_vox(Voxf,t1,t2,sf)
}

proc play_the_signal (int bn,int s1, int s2)
{

     if ( ! Use_buffer) {
<< " $s1 $s2  $sf\n"
      t2 = s2/sf
      t1 = s1/sf
<<"play_the_signal %V $t1 $t2 $sf \n"
      play_vox(Voxf,t1,t2,sf)
      return 1
     }

      sf = get_sigb_freq(bn)

  change = 0

    if ( s1 != Olds1 )       change =1
    if ( s2 != Olds2 )       change =1

  Olds1 = s1
  Olds2 = s2

# specific setups 
#{
# hal_jr now uses a SB16

    if ( (Myname @= "hal_jr") ) {
      ff=write_buffer(bn,tmp_wav,s1,s2)
      commentary("playing via $Myname rwavvocplay ")
      ff=command("chmod 666 ",tmp_wav)
      command("rwavvocplay ",tmp_wav)
      ff=wo_setvalue(sw,status_wo," ")
      return
    }
#}

    if (Myname @= "me109") {
# masscomp 5450
      play_signal(bn,s1,s2)
      return 1
    }

# play from buffer
# Generic sun,masscomp, intel (SB16)

   if ( scmp(Machine, "sun",3) || scmp(Machine,"sparc",5) ) {
# HAL2, babel
                  play_sun_audio (bn,s1,s2)
                  return 1
      }
   if (Machine @= "i386") {
# intel play
    if (Myname @= Wplay) 
          return (play_intel(bn,s1,s2))
      play_remote_intel(bn,s1,s2)
  }
}

proc stop_play()
{
   if ( scmp(Machine, "sun",3) || scmp(Machine,"sparc",5) ) <"zap audioplay"
   else if (!(Myname @= Wplay)) <"rsh $Wplay zap sb_play"
   else  <"zap sb_play"
}

proc play_hal_vox(voxf,t1,t2,sf)
{
   n = Round((t2-t1) * sf)
   short Sb[n]
   char Cb[n]
   swab = 0
   ns=read_signal_array(&Sb[0],voxf,0.0,(t2-t1),t1)
    p("b16b8 out ",ns," ",n,"\n")
    v_b16b8(&Sb[0],&Cb[0],ns)
   T= ofw(tmp_vox)

   if (T != -1) {
   ff=v_write(T,&Cb[0],ns)
   c_file(T)
   p("playing SBPRO ","\n")
   command(" sb_play -i ",tmp_vox,"-N -f",sf, "&")
   }
}


proc play_remote_vox(voxf,t1,t2,sf)
{
  <<"remote play via $Wplay"

   n = Round((t2-t1) * sf)
   if (n < 1000) n = 1000

   short Sb[n]
   ns=read_signal_array(&Sb[0],voxf,0.0,(t2-t1),t1)
# swap buf?
# if intel pcm playing on SUN yes
   bo = get_df_para(voxf,"byte_order")
   if ((Wp_machine @= "sun4") || (Wp_machine @= "sparc")) {
   if (bo != SUN_BO) {
   ff=v_swab(&Sb[0],ns)
   }
   }

   <<"$ns $n $tmp_vox \n"

   T= ofw(tmp_vox)

   if (T != -1) {
   ff=v_write(T,&Sb[0],ns,"short")
   c_file(T)

  <"rcp $tmp_vox $rcp_tmp_vox"
  <"rsh $Wplay sb_play -i $tmp_vox -N -f $sf &"
     }
}

proc play_vox(voxf, float t1, float t2, float sf)
{
   if (sf <= 0)  {
<<"$voxf ERROR sf $sf \n"
      return 
	}

   if (t1 > t2) { tmp =t1 ; t1 = t2; t2 = tmp ; }

float et
      et = t2

<<" %v $et \n"
  if (et == 0.0) {
<<" play_vox forcing et to 1.0 -FIXTHIS \n"
   et = 1.0
  }
   <<" $cproc %V $Myname $Wplay \n"
   if (Myname @= Wplay) {
     //  if ((t2 - t1) > 1.0) bkg = "&" ; else bkg =""
      <<"sb_play -i $voxf -s $t1 -e $et -W -A $Loud  -f $sf  & "

	  //      <"sb_play -i $voxf -s $t1 -e $et -W -A $Loud  -f $sf  & "
      <"sb_play -i $voxf -s $t1 -e $et -W -A $Loud    & "

      <<"done play $voxf \n"
    }
   else 
      play_remote_vox(voxf,t1,t2,sf)
}

proc record(wn)
{
  ns = 16000
  par_menu = "ed_record.m"
  value = table_menu(par_menu)
  remote = 0
    if ( value == 1 ) {

      r_dur = rd_menu(par_menu,0)
      s_time = rd_menu(par_menu,1)
      s_freq = rd_menu(par_menu,2)
      <<"r_dur $r_dur \n"
      ns = r_dur * s_freq
      ss = s_time * s_freq
# rs=record_signal(wn,ns,ss,s_freq)

      commentary("record on $Wrec")

    if ( (Myname @= Wrec )) {
      <"sb_rec -o rec.vox  -f $s_freq -e $r_dur &"
    }
    else {
      <"rsh $Wrec  bell "
      <"rsh $Wrec sb_rec -o rec.vox  -f $s_freq -e $r_dur"
      remotevox = "${Wrec}:rec.vox"
      <"rcp $remotevox ."
      remote = 1
    }

    if (r_dur > Max_dur) Max_dur = r_dur

    if (! remote) {
      t1 = get_time()
      bell()
      si_pause(1.0)

        while ( 1) {
          w_clearclip(wn)
          rs=read_signal(wn,"rec.vox")
          draw_taw(wn,0)
          t2 = get_time()
          dur = t2 -t1
            if (dur > r_dur) 
              break
          si_pause(2.0)
        }
     }

      rs=read_signal(wn,"rec.vox")
     ff=w_SetRS(wn,0,-32000,r_dur,32000)
      draw_taw(wn,0)
      w_store(wn)
    }
}

proc play_opts (how)
{
    if (how @= "Play_W") return   play_window(tw)
    if (how @= "Play_SR") return  play_sr(tw)
    if (how @= "StopPlay") return stop_play()
     return 0
}

proc play_BE(aw)
{
      the_sf = check_sf(aw)
      rs=w_GetRS(aw)
      s1= rs[1] * the_sf
      s2 = rs[3] * the_sf

      ds = (s2-s1)/6
# play first 1/4
      play_the_signal (sw,s1,s1+ds)
# play last 1/4
      play_the_signal (sw,s2-ds,s2)
}

# 

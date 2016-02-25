# UPE TRANSCRIPTION
set_debug(-2)

mach = get_arch()
myname = get_uname(1)
print (mach, " ",myname)
if (mach @= "sun") {
sun = 1
}
else {
sun = 0
}

s_display=get_env_var("DISPLAY")
display=str_pat(s_display,":0")

ff=o_print(display,"\n")

ff=si_pause(3)
n =get_sip_wnu()
print (n)

the_version = "3.6a"

stitle = str_cat("UPET_V",the_version)
w_title(n,stitle)
w_store(n)


char MS[120]
float MO[10]

# mono or color
Mono = 1

define_proc set_cmap
set_cmap(ng)
{
	Np = get_planes()
	if ( Np > 2 ) {
	    Fkgrey = 0
	    rainbow()
            Mono = 0
	}
	else {
	    Fkgrey = 1
	}
    
	if ( Np > 4) {
	   Gindex = 8
	}
	else {
		if (ng >= 16) {
			Gindex = 8
			ng = 16
		}
		if (ng == 8) {
			Gindex = 8
		}
	}

	ff=set_gsmap(ng,Gindex)
	si_pause(1)
	return (ng)
}

define_proc play_the_signal
play_the_signal (sw,s1,s2)
{
o_print(s1," ",s2,"\n")
change = 0
if ( (s1 != Olds1) || (s2 != Olds2) ) {
change =1
}
Olds1 = s1
Olds2 = s2

if (display @= "jonathan") {
 do_acv=get_env_var("ACPLAY")

 if (change) {

       if (myname @= "HAL2") {
           cfile = "/mnt/hal/SPEECH/tmp/cvox"
       o_print("writing ",cfile,"\n")
       }

       if (myname @= "HAL") {
           cfile = "/home/SPEECH/tmp/cvox"
       o_print("writing ",cfile,"\n")
       }

     ff=write_buffer(sw,cfile,s1,s2)
     ff=command("chmod 666 ", cfile )

#ff=command("rsh hal2 audioconvert -F -i rate=16000,encoding=linear16,channels=mono  -o /mnt/hal/SPEECH/tmp/bvox /mnt/hal/SPEECH/tmp/cvox")

      ff=command("rsh hal2 /export/home/mark/acv")


       if (myname @= "HAL2") {
           bfile = "/mnt/hal/SPEECH/tmp/bvox"
       }

       if (myname @= "HAL") {
           bfile = "/home/SPEECH/tmp/bvox"
       }

      ff=command("chmod 666 ", bfile)

    }

  if (do_acv @= "YES") {
    o_print("now_playing bvox")
    ff=command("rsh","jonathan","c:\\util\\wplany.exe","o:\\tmp\\bvox")
  }
}
else {

   the_file="/home/SPEECH/tmp/tmp_svox"
   hal2_file="/mnt/hal/SPEECH/tmp/tmp_svox"

if (myname @= "HAL2") {
if (change) {
ff=write_buffer(sw,hal2_file,s1,s2)
ff=command("chmod 666 ",hal2_file)
}
}
else {
if (change) {
ff=write_buffer(sw,the_file,s1,s2)
ff=command("chmod 666 ",the_file)
}
}

if (myname @= "HAL2") {
o_print("rsh play_c30")
ff=command("rsh hal play_c30",the_file,"16000")
}
else {
ff=command("play_c30",the_file,"16000")
}
}
}

define_proc mouse_select
mouse_select (sw)
{
		ff=w_time_curs(sw)
		ff=show_curs(1,-1,-1,"right_arrow",7,7)
		gsr =sw
                sr_was_set = 0

# left start time 
# right but  endtime 
# mid_but in clip region play: 
# mid_but outside window exit
# ESC key escape
# RET play

		while (gsr > 0) {
		ff=show_curs(1,-1,-1,"right_arrow",7,7)

		    gsr = get_sr(2)

		    o_print(gsr,"\n")

		    if ( gsr > 0) {
                        sr_was_set = 1
			sw = gsr
		        s1 = get_srs(sw)
			s2 = get_srf(sw)
			Z0 = s1
			Z1 = s2
			ff=w_set_wo_value(sw,status_wo,s1)
			o_print(s1," ",s2,"\n")
			play_the_signal(sw,s1*16000,s2*16000)
		    }

		}

# for escape out of get_sr with valid window but no play

                     if (gsr < 0) {
                       sr_was_set = 1
                       sw = -1 * gsr
                o_print("esc sw now ",sw," ",gsr,"\n")
                     }

                 if (sr_was_set) {
		        s1 = get_srs(sw)
			s2 = get_srf(sw)
			Z0 = s1
			Z1 = s2
                       }

                ff=show_curs(1,-1,-1,"cross")
                return sr_was_set
}


define_proc put_label
put_label (sw,the_ttype)
{
add_more = 0
label = "NULL"

  label = query_w("PUT_LABEL","enter label:",label)
  k = str_len(label)

 if (k < 1) {
            return 0
            }

	if ( ! (label @= "NULL") ) {
	    bell()
	    s1 = get_srs(sw)
	    s2 = get_srf(sw)

	    sp1 = Trunc(s1*16000)
	    sp2 = Trunc(s2*16000)
	    ds = sp2 -sp1
	    o_print(s1," ",s2,"\n")
	ff=w_file(A,sp1," ",sp2," ",label,"\n")
	   if (Transcribe ) {
	    nl=add_label(the_ttype,label,s1,s2)
	o_print("add_lab ",s1," ",s2,"\n")
		}
	    ff=place_label(lw,label,s1,s2,0.25,1)
	    ff=place_label(pw,label,s1,s2,0.25,1)
	    ff=place_label(tw,label,s1,s2,0.25,1)
#	    ff=w_set_wo_value(tw,status_wo,nl)
            set_sr(sw,sp2,sp2+ds)
	    add_more = 1
	}
        return add_more
}


define_proc paint_the_labels
paint_the_labels ()
{
		ff=w_clip_clear(lw)
                ff= w_refresh(lw)
		ff=setpen(lw,"red",1)
		ff=paint_labels(timit_w,lw,0,0.5)
		ff=paint_labels(timit_w,pw,0,0.2)
		ff=paint_labels(timit_gp,lw,1,0.2)
		text(lw,timit_file,0.9,0.85,1)
		ff=setpen(tw,"red",1)
		ff=w_clip_clear(tw)
                ff=w_refresh(tw)
		ff=paint_labels(timit_gp,tw,1,0.2)
		ff=setpen(tw,"blue",1)
		ff=paint_labels(timit_p,tw,0,0.75)
		setpen(tw,"black",1)
}

define_proc get_data_files
get_data_files()
{
sg_file = str_cat(timit_file,".sg")
rms_file = str_cat(timit_file,".rms")
spp_file= str_cat(timit_file,".spp")
}



define_proc read_the_labels
read_the_labels ()
{
set_debug(0)
reset_label_set(timit_w)
reset_label_set(timit_p)
reset_label_set(timit_gp)

op = decision_w("TRANSCRIBE","transcribe ? (word or UPE) or Just View "," WORD ", " UPE ", " VIEW ")

Transcribe_type = op

if (op @= "VIEW" ) {
Transcribe = 0
}

if (op @= "WORD" ) {
tok_type = timit_w
}

if (op @= "UPE" ) {
tok_type = timit_gp
}

lab_file = str_cat(timit_file,".phn")
oupe_file = str_cat(timit_file,".oupe")
guplab_file = str_cat(timit_file,".gup")
upe_file = str_cat(timit_file,".upe")
wrd_file = str_cat(timit_file,".wrd")
o_print(wrd_file," ",upe_file,"\n")


k=read_timit_labels(timit_w,wrd_file)
if (k) {
paint_labels(timit_w,lw,0,0.5)
}
k=read_timit_labels(timit_p,lab_file)
if (k) {
paint_labels(timit_p,tw,0,0.75)
}

if (Transcribe_type @= "UPE") {
k=read_timit_labels(timit_gp,upe_file)
}

if (Transcribe_type @= "VIEW") {
k=read_timit_labels(timit_gp,upe_file)
}


if (k) {
ff=setpen(tw,"blue",1)
paint_labels(timit_gp,tw,1,0.2)
write_timit_labels(timit_gp,oupe_file,timit_file)
}
set_debug(-1)
}

define_proc paint_win_labs
paint_win_labs (xw, ttype)
{
		ff=w_clip_clear(xw)
		ff=w_refresh(xw)
		scale_taw(xw)
		ff=paint_labels(ttype,xw,1,0.25)
}

define_proc do_zoom
do_zoom (bt,et)
{
		ff=show_curs(1,-1,-1,"watch")
		w_clip_clear(tw)
		o_print("time ",bt," ",et,"\n")

                dz = (et-bt)/6
                bt = bt -dz
                et = et +dz
                if (bt < 0) {
                bt = 0
                }
                if (et > Endtime ) {
                et = Endtime
                }
  		read_the_signal(bt,(et-bt),0)
		do_pt(lw)
		paint_the_labels()
		set_sr_times(pw,bt,et)
                show_sr(pw)
		ff=show_curs(1,-1,-1,"cross")
}

define_proc do_plot_track
do_plot_track (sw)
{
        rx=get_w_rs(tw,0)
        rX=get_w_rs(tw,2)
	set_w_rs(spw,0,rx)
	set_w_rs(spw,2,rX)
	pt_file="tran.spp"
	isfp =f_exist(pt_file,0, 320)
	ff=w_clip_clear(spw)
        ff=setpen(spw,"blue",1)
	ff=plot_chan(spw,pt_file,1,1,0,5,2)
        ff=setpen(spw,"red",1)
	ff=plot_chan(spw,pt_file,0,1,0,5,2)
	set_w_rs(pw,0,rx)
	set_w_rs(pw,2,rX)
	isfp =f_exist(rms_file,0, 320)
	ff=w_clip_clear(pw)
	ff=plot_chan(pw,rms_file,0,1,0,5,2)
}


define_proc scale_taw
scale_taw(awin)
{
	    rx=get_w_rs(awin,0)
	    rX=get_w_rs(awin,2)
	    dx = rX - rx
	    x_inc = get_incr( dx)
	    x2 = x_inc 
# label at x_inc "whole" intervals
	    x0 = rx / x_inc + 0.5
	    x0 = Round ( x0) * x_inc
	    x1 = rX / x_inc + 0.5
	    x1 = Round (x1) * x_inc

	    ticks(awin,1,x0,x1,x2,0.07)
	    ticks(awin,3,x0,x1,x2,0.07)
	    ff=w_clip_border(awin)
	    ff=axnum(awin,1,x0,x1,2*x2,-2.0,"g")
}

define_proc get_the_file
get_the_file ()
{
f_ok = 0
get_file = 1
  allf="sa1"
# list of timit files in dir
 set_si_error(0)

 wjunk=get_alias("WORK/junk")
 ff=command("ls *.wav > ", wjunk)
 af=o_file(wjunk,"r")

 if ( !get_si_error() ) {
 tf=r_file(af)
 tf=str_pat(tf,".wav")
 allf=str_cat(tf,",")

 rdit = 1
 while (rdit) {
 tf=r_file(af)
 tf=str_pat(tf,".wav")
 if (get_si_error() ){
 rdit = 0
 }
 else {
 allf=str_cat(allf,tf,",")
 }
 }

 c_file(af)
 }
	ff=show_curs(1,-1,-1,"cross")
 while (get_file) {
 timit_file=get_mem("timit_file")
 timit_file=query_w("SIGNAL_FILE",allf,timit_file)
  put_mem("timit_file",timit_file)
  if (timit_file @= "NULL") {
     return (f_ok)
  }

  sig_file = str_cat(timit_file,".wav")
  sz = f_exist(sig_file,0,0,1)
  print(timit_file, "  ",sz)
  if (sz > 0) {
    get_file = 0
    f_ok = 1
   }
 }
 return (f_ok)
}



define_proc show_sg
show_sg ()
{

	ff=show_curs(1,-1,-1,"watch")
	ngl = set_cmap(ngl)
        rx=get_w_rs(tw,0)
        rX=get_w_rs(tw,2)
	set_w_rs(spw,0,rx)
	set_w_rs(spw,2,rX)
# assuming 16 kHZ sample frequency
	set_w_rs(spw,1,0)
	ff=set_w_rs(spw,3,8000)
#	ff=write_signal(tw,"tran.vox")
#	job_nu=gs_job(prog, "-i", "tran.vox", "-o",sg_file,\
#"-b", fil_bw ,"-s", f_shift ,"-p",pre)
#	ff=f_exist(job_nu,0,30)
	
	print(sg_file)
	ff=w_clip_clear(spw)
#err=d_image(spw,sg_file,Fkgrey,ngl,Gindex,min_v,max_v,1,intpx,0,0,0,st_fr)

	intpx = 2
err=d_image(spw,sg_file,Fkgrey,ngl,Gindex,min_v,max_v,1,intpx,0,0,0)
	ff=w_store(spw)
	ff=show_curs(1,-1,-1,"cross")
}

define_proc show_rms
show_rms ()
{
	ff=show_curs(1,-1,-1,"watch")

#	ff=write_signal(tw,"tran.vox")
#	job_nu=gs_job("rms_zx", "-i", "tran.vox", "-o",rms_file,\
#	"-l", "10" ,"-s", "5")
#	ff=f_exist(job_nu,0,30)

	ff=w_clip_clear(pw)
        rx=get_w_rs(tw,0)
        rX=get_w_rs(tw,2)
# no scroll
#	set_w_rs(pw,0,rx)
#	set_w_rs(pw,2,rX)

	set_w_rs(pw,0,0)
	set_w_rs(pw,2,Endtime)
	set_w_rs(pw,1,-32000)
	ff=set_w_rs(pw,3,32000)
	draw_signal(pw,0)
	ff=w_store(pw)
	set_w_rs(pw,1,0)
	ff=set_w_rs(pw,3,2)
	plot_chan(pw,rms_file,0,1,0,5,2)
        ff=setpen(pw,"red",1)
	plot_chan(pw,rms_file,1,1,0,7)
	ff=w_store(pw)
	ff=show_curs(1,-1,-1,"cross")
}

define_proc read_the_signal
read_the_signal (fstart,dur, read_it)
{
o_print(fstart," ",dur,"\n")

   if (read_it) {
		clr_buf(tw)
		clr_buf(pw)
success = read_signal(tw,sig_file,0.0,dur,fstart,0.75,0,1,1024,16000,"short",1)
		n_dur = success/ Sf
		sp1 = 0
		sp2 = success
	        Endtime = n_dur
		Z0 = 0
		Z1 = Endtime
		copy_sr(tw)
		splice(pw)
ff=o_print(display)
if (display @= "jonathan") {


       if (myname @= "HAL2") {
           sfile = "/mnt/hal/SPEECH/tmp/svox"
       o_print("writing ",sfile,"\n")
       }

       if (myname @= "HAL") {
           sfile = "/home/SPEECH/tmp/svox"
       o_print("writing ",sfile,"\n")
       }

       ff=write_buffer(tw,sfile,0,success)
       ff=command("chmod 666 ", sfile)

       if (myname @= "HAL2") {
           afile = "/mnt/hal/SPEECH/tmp/avox"
       }

       if (myname @= "HAL") {
           afile = "/home/SPEECH/tmp/avox"
       }

    ff=command("chmod 666 ", afile)
    ff=command("rsh hal2 /export/home/mark/acva")
}
   }
   else {
	n_dur = dur
        success = dur * Sf
	sp1 = fstart * Sf
	sp2 = (fstart+n_dur) * Sf
		Z0 = fstart
		Z1 = fstart +n_dur
   }
		ff=w_clip_clear(tw)
		ff=w_clip_clear(lw)
		ff=setpen(tw,"blue",1)
		draw_signal(tw,sp1,sp2)
		ff=w_store(tw)
		w_clip_border(tw)
		set_w_rs(tw,0,fstart)
		set_w_rs(tw,2,fstart+n_dur)

		set_w_rs(lw,1,0)
		set_w_rs(lw,3,400)
                if (1) {
		set_w_rs(lw,0,fstart)
		set_w_rs(lw,2,fstart+n_dur)
                }
                else {
	                lws = fstart -1.0
        	        lwf = fstart+n_dur + 1.0
                	if (lws < 0) {
                        lws = 0
			}

                	if (lwf >  Endtime) {
                        lwf = Endtime
			}

                	set_w_rs(lw,0,lws)
			set_w_rs(lw,2,lwf)
                }
	
		scale_taw(tw)

		text(lw,timit_file,0.9,0.85,1)
		set_sr_times(tw,Z0,Z1)
		ff=w_store(tw)

#		ff=write_signal(tw,"tran.vox")
                return (success)
}


define_proc do_gettok
do_gettok (ttype)
{
	tok = -1
	but = 0
        findtok = 1
        key = -1
        nn = 1
		while ( findtok) {
			me = get_mouse_event(&MO[0])
			but = MO[0]
                        wnu = MO[3]
		        key = MO[9]
                o_print(key,"\n")
                key = Trunc(key)
                ckey = dec_ascii(key)

	        if ( (but > 0) || (wnu < 0)) {
		   findtok = 0
		}

		if (ckey @= "p") {
		  findtok = 0
                }

		if (ckey @= "r") {
		  findtok = 0
                  nn = 2
                }

		if (ckey @= "l") {
		  findtok = 0
                  nn = -1
                }

		if (ckey @= "z") {
		  findtok = 0
                  return (-2)
                }
              	
		ff=o_print("but ",but," ",wnu," ",findtok,"\n")
                }

		tim = MO[4] 

#		#if (wnu > 0 && tim >0 && tim < Endtime) { 

		if (wnu > 0 ) {
			tok = search_label_time(ttype,tim,1,nn)
		}


        o_print("\n",tok," ",wnu," ",me," ",MO[3],"\n")
	return (tok)
}

define_proc do_delete
do_delete (the_ttype)
{

		ff=w_show_curs(tw,1,"pirate",0.5,0.5)
		tok = do_gettok(the_ttype)
		if ( tok >= 0 ) {
			show_token(the_ttype,tok)
			lab = get_label_name(the_ttype,tok)
			ff=w_set_wo_value(tw,status_wo,lab)
			op = decision_w("DELETE_LABEL",lab," yes ", " no ")
			
			if (op @= "yes" && Transcribe ) {
			bell()
                        o_print("Deleting ",lab,"\n")
			delete_label(the_ttype,tok)
                        update_files()
			paint_win_labs(tw,the_ttype)
			paint_win_labs(lw,the_ttype)
			}	
			}

		ff=show_curs(1,-1,-1,"cross",7,7)
}

 
define_proc do_rename
do_rename (the_ttype)
{
       ff=show_curs(1,-1,-1,"hand",7,7)
       tok = do_gettok(the_ttype)
       did_sr = 0
	  if ( tok >= 0 ) {
	     lab = get_label_name(the_ttype,tok)

	     start_t = get_label_start(the_ttype,tok)
	     stop_t =  get_label_stop(the_ttype,tok)

	     if (stop_t > start_t) {
	     play_the_signal(tw,start_t * 16000,stop_t * 16000)
             }

	     op = decision_w("CHANGE_TIMES",lab," yes ", " no ")

             if ( op @= "yes") {
		        ff=set_sr_times(tw,start_t,stop_t)
			did_sr =mouse_select(tw)
                        if (did_sr) {
	                s1 = Z0
	                s2 = Z1
                 o_print(s1," ",s2,"\n")
                 ff=set_label_times(the_ttype,tok,s1,s2)
                        }
             }

	     ff=w_set_wo_value(tw,status_wo,lab)
             e_nu_lab = "new_lab_:";
             e_nu_lab = str_cat(e_nu_lab,lab)

	     rlabel=query_w("RENAME_LABEL",e_nu_lab,lab)

	     o_print(rlabel,"\n")

		  if ( ! (rlabel @= "NULL")) {
		     bell()
	        if (Transcribe ) {
		     rename_label(the_ttype,tok,rlabel)
		}
		     }
			paint_the_labels()
		}
	ff=show_curs(1,-1,-1,"cross",7,7)
}
 
define_proc play_token
play_token (the_ttype)
{
play_tokens = 1
      
        ff=o_print("play_token","\n")
	ff=w_show_curs(tw,1,"hand",0.5,0.5)
	start_t = 0
	stop_t = Endtime

      while (play_tokens) {
			
       ff=show_curs(1,-1,-1,"hand",7,7)
       tok = do_gettok(the_ttype)

	if ( tok >= 0 ) {
	     lab = get_label_name(the_ttype,tok)
	     start_t = get_label_start(the_ttype,tok)
	     stop_t = get_label_stop(the_ttype,tok)
      
	     if (stop_t > start_t) {
	     w_real_xor(tw,start_t,-32000,stop_t,32000)
	     play_the_signal(tw,start_t * 16000,stop_t * 16000)
	     w_real_xor(tw,start_t,-32000,stop_t,32000)
             mt = start_t + (stop_t-start_t)/2
	     ff=w_show_curs(pw,2,"hand",mt,0)
             }
#	     o_print(lab,"\n")
	}
        else {
	play_tokens = 0
          if (tok == -2) {
          do_zoom(start_t,stop_t)
          }
	}
       }
      ff=show_curs(1,-1,-1,"cross",7,7)
}

define_proc show_token
show_token (the_ttype,tok)
{
	if ( tok >= 0 ) {
	     start_t = get_label_start(the_ttype,tok)
	     stop_t = get_label_stop(the_ttype,tok)
	     w_real_xor(tw,start_t,-32000,stop_t,32000)
	 }
}

define_proc spec_buttons
spec_buttons (sw)
{
y0 = .025
y1 = .2
wd = .08
x0 = wd
x1 = x0 + wd

ff=w_set_wo(sw,0,"SG",0,x0,y0,x1,y1,3,white)
x0 = x0 + .12
x1 = x0 + wd
ff=w_set_wo(sw,0,"RMS_ZX",0,x0,y0,x1,y1,1,blue)
x0 = x0 + .12
x1 = x0 + wd
}

define_proc su_buttons
su_buttons (sw)
{
y0 = .025
y1 = .125
wd = .048
sp = wd + .01
x0 = wd
x1 = x0 + wd
ff=w_set_wo(sw,0,"PLAY",0,x0,y0,x1,y1,3,green)
x0 = x0 + sp
x1 = x0 + wd
ff=w_set_wo(sw,0,"SEL",0,x0,y0,x1,y1,3,green)
x0 = x0 + sp
x1 = x0 + wd
ff=w_set_wo(sw,0,"<->",0,x0,y0,x1,y1,1,blue)
x0 = x0 + sp
x1 = x0 + wd
ff=w_set_wo(sw,0,"SR",0,x0,y0,x1,y1,1,blue)
x0 = x0 + sp
x1 = x0 + wd
ff=w_set_wo(sw,0,"P_TOK",0,x0,y0,x1,y1,1,blue)
x0 = x0 + sp
x1 = x0 + wd
ff=w_set_wo(sw,0,"P_WORD",0,x0,y0,x1,y1,1,blue)
x0 = x0 + sp
x1 = x0 + wd
ff=w_set_wo(sw,0,"RENAM",0,x0,y0,x1,y1,1,blue)
x0 = x0 + sp
x1 = x0 + wd
ff=w_set_wo(sw,0,"ADD",0,x0,y0,x1,y1,1,green)
x0 = x0 + sp
x1 = x0 + wd
ff=w_set_wo(sw,0,"DEL",0,x0,y0,x1,y1,1,red)
x0 = x0 + sp
x1 = x0 + wd
ff=w_set_wo(sw,0,"FORW",0,x0,y0,x1,y1,1,blue)
x0 = x0 + sp
x1 = x0 + wd
ff=w_set_wo(sw,0,"REV",0,x0,y0,x1,y1,1,blue)
x0 = x0 + sp
x1 = x0 + wd
ff=w_set_wo(sw,0,"WRITE",0,x0,y0,x1,y1,1,blue)
x0 = x0 + sp
x1 = x0 + wd
ff=w_set_wo(sw,0,"FILE",0,x0,y0,x1,y1,1,blue)
x0 = x0 + sp
x1 = x0 + wd
ff=w_set_wo(sw,0,"P_L",0,x0,y0,x1,y1,1,blue)
x0 = x0 + sp
x1 = x0 + wd
ff=w_set_wo(sw,0,"EXIT",0,x0,y0,x1,y1,1,blue)
}

fir_prog = "afb"

define_proc do_pt
do_pt (sw)
{
ff=w_clear(sw)
pt_file="tran.pt"
#spp_file="tran.spp"
ph_file="tran.ph"
frlen = 44
pow_thres = 65

do_the_px = 0

if (do_the_px) {
ff=print("starting cepstum pitch extraction")
job_nu=gs_job("ceppt","-i","tran.vox","-o","ceppt.df",\
"-l",frlen,"-s",7,"-n",512,"-S",3,"-p",pt_file,"-t",1.6,"-b",60,"-e",400,"-P",pow_thres,"-A","-z",ph_file,"-x",spp_file)
isfp =f_exist(job_nu,0,320)
ff=print("finished cepstum pitch extraction")
}
# smoothed pitch
ff=setpen(sw,"blue",1)
set_w_rs(sw,1,0)
ff=set_w_rs(sw,3,400)
ff=plot_chan(sw,spp_file,1,1,0,5,2)
# raw pitch
ff=setpen(sw,"red",1)
ff=plot_chan(sw,spp_file,0,1,0,5,2)
		scale_taw(sw)
w_store(sw)
}


define_proc go_forward
go_forward()
{
	w_clip_clear(tw)
#			file_start  = file_start + file_shift
        rx=get_w_rs(tw,0)
        rX=get_w_rs(tw,2)
	frw_dur = rX-rx
	frw_start = rx + frw_dur/2
            if ((frw_start + frw_dur) > Endtime) {
                 frw_start = Endtime - frw_dur
              }
                        
	read_the_signal(frw_start,frw_dur,0)
#	ff=w_real_xor(pw,frw_start,0,frw_start+frw_dur,400)

	do_pt(lw)
	paint_the_labels()
}

define_proc go_back
go_back()
{
	w_clip_clear(tw)
        rx=get_w_rs(tw,0)
        rX=get_w_rs(tw,2)
	frw_dur = rX-rx
	frw_start = rx - frw_dur/2
			if (frw_start < 0) {
			    frw_start = 0
                            }
	read_the_signal(frw_start,frw_dur,0)
	do_pt(lw)
	paint_the_labels()
}


define_proc new_file
new_file()
{
	o_print("new file")
	go_on=get_the_file ()
            if (go_on) {
                success= read_the_signal(0,0,1)
		file_start = 0
		get_data_files()
                show_sg()
		show_rms()
		do_pt(lw)
		read_the_labels()
             }
}

define_proc do_exit
do_exit()
{
	op = decision_w("EXIT","exit  "," yes ", " no ")
	 if (op @= "yes") {
		w_delete(tw)
		w_delete(spw)
		w_delete(lw)
		w_delete(pw)
            ff=show_curs(1,-1,-1,"cross",7,7)
		ff=exit_si()
		}
}

define_proc zoom_out
zoom_out()
{
		w_clip_clear(tw)
		read_the_signal(0,Endtime,0)
		paint_the_labels()
}

define_proc zoom_in
zoom_in()
{
            z1 = get_srs(pw)
            z2 = get_srf(pw)
	    do_zoom(z1,z2)

}

define_proc do_a_select
do_a_select()
{
	 ff=w_show_curs(pw,1,"right_arrow",0.5,0.5)
	 did_sr=mouse_select(pw)
         if (did_sr) {
	 do_zoom(Z0,Z1)
         }
#	 ff=w_real_xor(pw,Z0,0,Z1,400)
}

define_proc update_files
update_files()
{
	    if (Transcribe_type @= "UPE") {
		write_timit_labels(timit_gp,upe_file,timit_file)
                  }
	    if (Transcribe_type @= "WORD") {
		write_timit_labels(timit_w,wrd_file,timit_file)
                }
}


define_proc add_some_tokens
add_some_tokens()
{
	add_tokens = 1
	while (add_tokens) {
		ff=o_print("add_label","\n")
		ff=w_show_curs(tw,1,"right_arrow",0.5,0.5)
		did_sr= mouse_select(tw)
                if (did_sr) {
		w_real_xor(tw,Z0,-32000,Z1,32000)
                set_sr_times(tw,Z0,Z1)
		add_tokens=put_label(tw,tok_type)
	        paint_the_labels()
                }
                else {
                add_tokens =0
                }
                if (add_tokens) {
                  update_files()
              }
	 }
}

define_proc write_tokens
write_tokens()
{
   if (Transcribe ) {
	    
	    if (Transcribe_type @= "UPE") {
                write_labels(timit_gp,guplab_file,timit_file)
		write_timit_labels(timit_gp,upe_file,timit_file)
             }
	    if (Transcribe_type @= "WORD") {
		write_timit_labels(timit_w,wrd_file,timit_file)
             }
    }
}


define_proc the_menu
the_menu (the_choice)
{
        o_print(the_choice)

        ff=show_curs(1,-1,-1,"watch")
set_debug(0)
        if ( the_choice @= "REDRAW")) {
            ff=show_curs(1,-1,-1,"cross",7,7)
            return 1
	}



	if (  the_choice @= "ADD" ) {
                add_some_tokens()
                 return 1
          }

	if (  the_choice @= "DEL" ) {
	    do_delete(tok_type)
            return 1
	}


	if (  the_choice @= "RENAM" ) {
	    do_rename(tok_type)
            return 1
	}

	if ( the_choice @= "SEL" ) {
            do_a_select()
            return 1
	}

	if ( the_choice @= "PLAY" ) {
	    play_the_signal(tw,sp1,sp2)
            return 1
        }

	if ( the_choice @= "SG" ) {
              show_sg()
              return 1	
	}

	if (  the_choice @= "RMS_ZX" ) {
		show_rms() 
              return 1	
	}

	if ( the_choice @= "P_TOK" ) {
		play_token(timit_gp)
               return 1
	}

	if ( the_choice @= "P_WORD" ) {
		play_token(timit_w)
              return 1
	}

	if ( the_choice @= "P_L" ) {
		paint_the_labels()
              return 1
	}


	if (  the_choice @= "FORW" ) {
                        go_forward()
                        return 1
		}

	if ( the_choice @= "REV" ) {
                   go_back()
                   return 1
	}

	if ( the_choice @= "FILE" ) {
                   new_file()
                   return 1
		}

	if ( the_choice @= "EXIT" ) {
                   do_exit()
                   return 1
	   }

	if ( the_choice @= "<->" ) {
                zoom_out()
                return 1
	}

	if ( the_choice @= "SR" ) {
		zoom_in()
                return 1
	}

	if (the_choice @= "WRITE") {
                 write_tokens()
               return 1
	}


}




# get colors right

ngl = set_cmap(16)

if (Mono) {
white = "white"
blue = "white"
red  = "white"
green = "white"
}
else {
white = "white"
blue = "blue"
red  = "red"
green = "green"
}



# windows
wx = 0.05
wX = 0.98

# pitch window
pw = w_create(1,0)
w_resize(pw,wx,0.84,wX,0.99,1)
w_map(pw)
w_clear(pw)
ff=w_border(pw)
ff=w_title(pw,"pitch")

# spectrogram window
spw = w_create(1,0)
w_resize(spw,wx,0.63,wX,0.83,1)
w_map(spw)
w_clear(spw)
ff=w_border(spw)
ff=w_title(spw,"sgraph")
# time-amp window
tw = w_create(1,0)
w_resize(tw,wx,0.25,wX,0.62,1)
w_map(tw)
w_clear(tw)
w_border(tw)
ff=w_title(tw,"tran")
# label window
lw = w_create(1,0)
w_resize(lw,wx,0.01,wX,0.20,1)
w_map(lw)
w_clear(lw)
ff=w_title(lw,"label")
ff=w_border(lw)
su_buttons(tw)
ff=spec_buttons(spw)


Sf = 16000
file_start = 0.0
file_dur = 1.0
file_shift = 1.0

 
read_devices()
# get signal space
ss= get_signal_space(320000)

if ( ss == -1) {
exit_si()
}



sp1 = 0
sp2 = ss
Olds1 = 0
Olds2 = 0

Endtime = 1.0
Z0 = 0
Z1 = 1.0

timit_file = "sa1"
sig_file = "sa1.wav"
ff=o_print(display)
go_on= get_the_file()
if ( !go_on) {
ff=exit_si()
}
ff=w_title(tw,timit_file)

cx = 0.05
cX = 0.99
cY = 0.98
w_set_clip(pw,cx,0.1,cX,cY)
w_set_clip(tw,cx,0.15,cX,cY)
w_set_clip(spw,cx,0.25,cX,cY)
w_set_clip(lw,cx,0.1,cX,cY)

status_wo=w_set_wo(tw,"WO_BUTTON_VALUE"," ",2,0.05,0.95,0.55,0.99," ")

w_redraw_wo(tw)
ff=w_clip_border(tw)
ff=w_clip_border(lw)

ff=w_redraw_wo(spw)

success= read_the_signal(file_start,0,1)
o_print(success,"\n")

if (success <= 0) {
exit_si()
}

if (display @= "jonathan") {
ff=write_buffer(tw,"/home/SPEECH/tmp/svox",0,success)
}

A=o_file("tran.lab","w")
lab_file = str_cat(timit_file,".phn")
guplab_file = str_cat(timit_file,".gup")
upe_file = str_cat(timit_file,".upe")
oupe_file = str_cat(timit_file,".oupe")
wrd_file = str_cat(timit_file,".wrd")
owrd_file = str_cat(timit_file,".owrd")
 

o_print(wrd_file,"\n")
# get a set of labels

timit_w = get_label_set(100)
o_print("label_set"," ",timit_w,"\n")
timit_p = get_label_set(500)
o_print("label_set"," ",timit_p,"\n")
timit_gp = get_label_set(500)
o_print("label_set"," ",timit_gp,"\n")


tok_type = timit_gp
Transcribe = 1
Transcribe_type = "UPE"
 


type = -1
choice = 1
time_stamp =0

# if abort/interrupt jump here

sw = tw

set_sip_jump()
len = 0

Fkgrey = 0
ngl = 16
Gindex = 8
min_v = 20
max_v= 80
intpx = 1
st_fr = 0

ngl = set_cmap(ngl)

sg_file = str_cat(timit_file,".sg")
rms_file = str_cat(timit_file,".rms")
spp_file= str_cat(timit_file,".spp")
get_data_files()

#show_sg()

show_rms()
do_pt(lw)
read_the_labels()

#paint_the_labels()


prog = "sg"

fil_bw = 100
f_shift = 2.5
pre = 90
op = "NO"

  while (1) {

        ff=show_curs(1,-1,-1,"spider",7,7)
	ff=w_wo_activate(sw)

	wnu=message_wait(&MS[0],&type,&len,&time_stamp)
	l=str_scan(&MS[0],&choice)
 
        sw = wnu

        ff=the_menu (choice)
        set_debug(-1)
  }

ff=exit_si()
	



# FEATURES BUGS & WANTS
# W highlite selected region
# W edit token (change start-stop) - done
# W ready-made alias for WORK - done 

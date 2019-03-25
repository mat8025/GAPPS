#/* -*- c -*- */

# UPE TRANSCRIPTION
set_debug(0)

mach = get_arch()
myname = get_uname(1)

  //if (mach @= "sun") {
  //sun = 1
  //}
  //else {
  //sun = 0
  //}


s_display=get_env_var("DISPLAY")
display=spat(s_display,":0")



si_pause(3)
n =get_sip_wnu()


the_version = "1.0"

stitle = scat("UPET_V",the_version)
w_title(n,stitle)
w_store(n)


char MS[120]
float MO[10]

# mono or color
Mono = 1

proc set_cmap(ng)
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

	set_gsmap(ng,Gindex)
	si_pause(1)
	return (ng)
}

// threaded play

proc play_the_signal (sw,s1,s2)
{

change = 0
if ( (s1 != Olds1) || (s2 != Olds2) ) {
change =1
}
Olds1 = s1
Olds2 = s2


     write_buffer(sw,cfile,s1,s2)
     command("chmod 666 ", cfile )

#command("rsh hal2 audioconvert -F -i rate=16000,encoding=linear16,channels=mono  -o /mnt/hal/SPEECH/tmp/bvox /mnt/hal/SPEECH/tmp/cvox")


//      command("chmod 666 ", bfile)





   the_file="/home/SPEECH/tmp/tmp_svox"

if (change) {
       write_buffer(sw,the_file,s1,s2)

}



}

proc mouse_select (sw)
{
		w_time_curs(sw)
		show_curs(1,-1,-1,"right_arrow",7,7)
		gsr =sw
                sr_was_set = 0

# left start time 
# right but  endtime 
# mid_but in clip region play: 
# mid_but outside window exit
# ESC key escape
# RET play

		while (gsr > 0) {
		show_curs(1,-1,-1,"right_arrow",7,7)

		    gsr = get_sr(2)



		    if ( gsr > 0) {
                        sr_was_set = 1
			sw = gsr
		        s1 = get_srs(sw)
			s2 = get_srf(sw)
			Z0 = s1
			Z1 = s2
			w_set_wo_value(sw,status_wo,s1)

			play_the_signal(sw,s1*16000,s2*16000)
		    }

		}

# for escape out of get_sr with valid window but no play

                     if (gsr < 0) {
                       sr_was_set = 1
                       sw = -1 * gsr



                     }

                 if (sr_was_set) {
		        s1 = get_srs(sw)
			s2 = get_srf(sw)
			Z0 = s1
			Z1 = s2
                       }

                show_curs(1,-1,-1,"cross")
                return sr_was_set
}


proc put_label (sw,the_ttype)
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

	w_file(A,sp1," ",sp2," ",label,"\n")
	   if (Transcribe ) {
	    nl=add_label(the_ttype,label,s1,s2)
	<<"add_lab $s1  $s2 \n"
		}
	    place_label(lw,label,s1,s2,0.25,1)
	    place_label(pw,label,s1,s2,0.25,1)
	    place_label(tw,label,s1,s2,0.25,1)
#	    w_set_wo_value(tw,status_wo,nl)
            set_sr(sw,sp2,sp2+ds)
	    add_more = 1
	}
        return add_more
}


proc paint_the_labels ()
{
		w_clip_clear(lw)
                 w_refresh(lw)
		setpen(lw,"red",1)
		paint_labels(timit_w,lw,0,0.5)
		paint_labels(timit_w,pw,0,0.2)
		paint_labels(timit_gp,lw,1,0.2)
		text(lw,timit_file,0.9,0.85,1)
		setpen(tw,"red",1)
		w_clip_clear(tw)
                w_refresh(tw)
		paint_labels(timit_gp,tw,1,0.2)
		setpen(tw,"blue",1)
		paint_labels(timit_p,tw,0,0.75)
		setpen(tw,"black",1)
}

proc get_data_files()
{
sg_file = scat(timit_file,".sg")
rms_file = scat(timit_file,".rms")
spp_file= scat(timit_file,".spp")
}



proc read_the_labels ()
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

lab_file = scat(timit_file,".phn")
oupe_file = scat(timit_file,".oupe")
guplab_file = scat(timit_file,".gup")
upe_file = scat(timit_file,".upe")
wrd_file = scat(timit_file,".wrd")
<<"$wrd_file  $upe_file \n"


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
setpen(tw,"blue",1)
paint_labels(timit_gp,tw,1,0.2)
write_timit_labels(timit_gp,oupe_file,timit_file)
}
set_debug(-1)
}

proc paint_win_labs (xw, ttype)
{
		w_clip_clear(xw)
		w_refresh(xw)
		scale_taw(xw)
		paint_labels(ttype,xw,1,0.25)
}

proc do_zoom (bt,et)
{
		show_curs(1,-1,-1,"watch")
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
		show_curs(1,-1,-1,"cross")
}

proc do_plot_track (sw)
{
        rx=get_w_rs(tw,0)
        rX=get_w_rs(tw,2)
	set_w_rs(spw,0,rx)
	set_w_rs(spw,2,rX)
	pt_file="tran.spp"
	isfp =f_exist(pt_file,0, 320)
	w_clip_clear(spw)
        setpen(spw,"blue",1)
	plot_chan(spw,pt_file,1,1,0,5,2)
        setpen(spw,"red",1)
	plot_chan(spw,pt_file,0,1,0,5,2)
	set_w_rs(pw,0,rx)
	set_w_rs(pw,2,rX)
	isfp =f_exist(rms_file,0, 320)
	w_clip_clear(pw)
	plot_chan(pw,rms_file,0,1,0,5,2)
}


proc scale_taw(awin)
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
	    w_clip_border(awin)
	    axnum(awin,1,x0,x1,2*x2,-2.0,"g")
}

proc get_the_file ()
{
f_ok = 0
get_file = 1
  allf="sa1"
# list of timit files in dir
 set_si_error(0)

 wjunk=get_alias("WORK/junk")
 command("ls *.wav > ", wjunk)
 af=o_file(wjunk,"r")

 if ( !get_si_error() ) {
 tf=r_file(af)
 tf=spat(tf,".wav")
 allf=scat(tf,",")

 rdit = 1
 while (rdit) {
 tf=r_file(af)
 tf=spat(tf,".wav")
 if (get_si_error() ){
 rdit = 0
 }
 else {
 allf=scat(allf,tf,",")
 }
 }

 c_file(af)
 }
	show_curs(1,-1,-1,"cross")
 while (get_file) {
 timit_file=get_mem("timit_file")
 timit_file=query_w("SIGNAL_FILE",allf,timit_file)
  put_mem("timit_file",timit_file)
  if (timit_file @= "NULL") {
     return (f_ok)
  }

  sig_file = scat(timit_file,".wav")
  sz = f_exist(sig_file,0,0,1)
  print(timit_file, "  ",sz)
  if (sz > 0) {
    get_file = 0
    f_ok = 1
   }
 }
 return (f_ok)
}



proc show_sg ()
{

	show_curs(1,-1,-1,"watch")
	ngl = set_cmap(ngl)
        rx=get_w_rs(tw,0)
        rX=get_w_rs(tw,2)
	set_w_rs(spw,0,rx)
	set_w_rs(spw,2,rX)
# assuming 16 kHZ sample frequency
	set_w_rs(spw,1,0)
	set_w_rs(spw,3,8000)
#	write_signal(tw,"tran.vox")
#	job_nu=gs_job(prog, "-i", "tran.vox", "-o",sg_file,\
#"-b", fil_bw ,"-s", f_shift ,"-p",pre)
#	f_exist(job_nu,0,30)
	
	print(sg_file)
	w_clip_clear(spw)
#err=d_image(spw,sg_file,Fkgrey,ngl,Gindex,min_v,max_v,1,intpx,0,0,0,st_fr)

	intpx = 2
err=d_image(spw,sg_file,Fkgrey,ngl,Gindex,min_v,max_v,1,intpx,0,0,0)
	w_store(spw)
	show_curs(1,-1,-1,"cross")
}

proc show_rms ()
{
	show_curs(1,-1,-1,"watch")

#	write_signal(tw,"tran.vox")
#	job_nu=gs_job("rms_zx", "-i", "tran.vox", "-o",rms_file,\
#	"-l", "10" ,"-s", "5")
#	f_exist(job_nu,0,30)

	w_clip_clear(pw)
        rx=get_w_rs(tw,0)
        rX=get_w_rs(tw,2)
# no scroll
#	set_w_rs(pw,0,rx)
#	set_w_rs(pw,2,rX)

	set_w_rs(pw,0,0)
	set_w_rs(pw,2,Endtime)
	set_w_rs(pw,1,-32000)
	set_w_rs(pw,3,32000)
	draw_signal(pw,0)
	w_store(pw)
	set_w_rs(pw,1,0)
	set_w_rs(pw,3,2)
	plot_chan(pw,rms_file,0,1,0,5,2)
        setpen(pw,"red",1)
	plot_chan(pw,rms_file,1,1,0,7)
	w_store(pw)
	show_curs(1,-1,-1,"cross")
}

proc read_the_signal (fstart,dur, read_it)
{

<<"$fstart $dur \n"

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

       write_buffer(tw,sfile,0,success)
       command("chmod 666 ", sfile)
       
   }
   else {
	n_dur = dur
        success = dur * Sf
	sp1 = fstart * Sf
	sp2 = (fstart+n_dur) * Sf
		Z0 = fstart
		Z1 = fstart +n_dur
   }
		w_clip_clear(tw)
		w_clip_clear(lw)
		setpen(tw,"blue",1)
		draw_signal(tw,sp1,sp2)
		w_store(tw)
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
		w_store(tw)

#		write_signal(tw,"tran.vox")
                return (success)
}


proc do_gettok (ttype)
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
              	
		o_print("but ",but," ",wnu," ",findtok,"\n")
                }

		tim = MO[4] 

#		#if (wnu > 0 && tim >0 && tim < Endtime) { 

		if (wnu > 0 ) {
			tok = search_label_time(ttype,tim,1,nn)
		}


        o_print("\n",tok," ",wnu," ",me," ",MO[3],"\n")
	return (tok)
}

proc do_delete (the_ttype)
{

		w_show_curs(tw,1,"pirate",0.5,0.5)
		tok = do_gettok(the_ttype)
		if ( tok >= 0 ) {
			show_token(the_ttype,tok)
			lab = get_label_name(the_ttype,tok)
			w_set_wo_value(tw,status_wo,lab)
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

		show_curs(1,-1,-1,"cross",7,7)
}

 
proc do_rename (the_ttype)
{
       show_curs(1,-1,-1,"hand",7,7)
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
		        set_sr_times(tw,start_t,stop_t)
			did_sr =mouse_select(tw)
                        if (did_sr) {
	                s1 = Z0
	                s2 = Z1
                 <<" $s1 $s2 \n"
                 set_label_times(the_ttype,tok,s1,s2)
                        }
             }

	     w_set_wo_value(tw,status_wo,lab)
             e_nu_lab = "new_lab_:";
             e_nu_lab = scat(e_nu_lab,lab)

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
	show_curs(1,-1,-1,"cross",7,7)
}
 
proc play_token (the_ttype)
{
play_tokens = 1
      

	w_show_curs(tw,1,"hand",0.5,0.5)
	start_t = 0
	stop_t = Endtime

      while (play_tokens) {
			
       show_curs(1,-1,-1,"hand",7,7)
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
	     w_show_curs(pw,2,"hand",mt,0)
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
      show_curs(1,-1,-1,"cross",7,7)
}

proc show_token (the_ttype,tok)
{
	if ( tok >= 0 ) {
	     start_t = get_label_start(the_ttype,tok)
	     stop_t = get_label_stop(the_ttype,tok)
	     w_real_xor(tw,start_t,-32000,stop_t,32000)
	 }
}

proc spec_buttons (sw)
{
y0 = .025
y1 = .2
wd = .08
x0 = wd
x1 = x0 + wd

w_set_wo(sw,0,"SG",0,x0,y0,x1,y1,3,white)
x0 = x0 + .12
x1 = x0 + wd
w_set_wo(sw,0,"RMS_ZX",0,x0,y0,x1,y1,1,blue)
x0 = x0 + .12
x1 = x0 + wd
}

proc su_buttons (sw)
{
y0 = .025
y1 = .125
wd = .048
sp = wd + .01
x0 = wd
x1 = x0 + wd
w_set_wo(sw,0,"PLAY",0,x0,y0,x1,y1,3,green)
x0 = x0 + sp
x1 = x0 + wd
w_set_wo(sw,0,"SEL",0,x0,y0,x1,y1,3,green)
x0 = x0 + sp
x1 = x0 + wd
w_set_wo(sw,0,"<->",0,x0,y0,x1,y1,1,blue)
x0 = x0 + sp
x1 = x0 + wd
w_set_wo(sw,0,"SR",0,x0,y0,x1,y1,1,blue)
x0 = x0 + sp
x1 = x0 + wd
w_set_wo(sw,0,"P_TOK",0,x0,y0,x1,y1,1,blue)
x0 = x0 + sp
x1 = x0 + wd
w_set_wo(sw,0,"P_WORD",0,x0,y0,x1,y1,1,blue)
x0 = x0 + sp
x1 = x0 + wd
w_set_wo(sw,0,"RENAM",0,x0,y0,x1,y1,1,blue)
x0 = x0 + sp
x1 = x0 + wd
w_set_wo(sw,0,"ADD",0,x0,y0,x1,y1,1,green)
x0 = x0 + sp
x1 = x0 + wd
w_set_wo(sw,0,"DEL",0,x0,y0,x1,y1,1,red)
x0 = x0 + sp
x1 = x0 + wd
w_set_wo(sw,0,"FORW",0,x0,y0,x1,y1,1,blue)
x0 = x0 + sp
x1 = x0 + wd
w_set_wo(sw,0,"REV",0,x0,y0,x1,y1,1,blue)
x0 = x0 + sp
x1 = x0 + wd
w_set_wo(sw,0,"WRITE",0,x0,y0,x1,y1,1,blue)
x0 = x0 + sp
x1 = x0 + wd
w_set_wo(sw,0,"FILE",0,x0,y0,x1,y1,1,blue)
x0 = x0 + sp
x1 = x0 + wd
w_set_wo(sw,0,"P_L",0,x0,y0,x1,y1,1,blue)
x0 = x0 + sp
x1 = x0 + wd
w_set_wo(sw,0,"EXIT",0,x0,y0,x1,y1,1,blue)
}

fir_prog = "afb"

proc do_pt (sw)
{
w_clear(sw)
pt_file="tran.pt"
#spp_file="tran.spp"
ph_file="tran.ph"
frlen = 44
pow_thres = 65

do_the_px = 0

if (do_the_px) {
print("starting cepstum pitch extraction")
job_nu=gs_job("ceppt","-i","tran.vox","-o","ceppt.df",\
"-l",frlen,"-s",7,"-n",512,"-S",3,"-p",pt_file,"-t",1.6,"-b",60,"-e",400,"-P",pow_thres,"-A","-z",ph_file,"-x",spp_file)
isfp =f_exist(job_nu,0,320)
print("finished cepstum pitch extraction")
}
# smoothed pitch
setpen(sw,"blue",1)
set_w_rs(sw,1,0)
set_w_rs(sw,3,400)
plot_chan(sw,spp_file,1,1,0,5,2)
# raw pitch
setpen(sw,"red",1)
plot_chan(sw,spp_file,0,1,0,5,2)
		scale_taw(sw)
w_store(sw)
}


proc go_forward()
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
#	w_real_xor(pw,frw_start,0,frw_start+frw_dur,400)

	do_pt(lw)
	paint_the_labels()
}

proc go_back()
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


proc new_file()
{

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

proc do_exit()
{
	op = decision_w("EXIT","exit  "," yes ", " no ")
	 if (op @= "yes") {
		w_delete(tw)
		w_delete(spw)
		w_delete(lw)
		w_delete(pw)
            show_curs(1,-1,-1,"cross",7,7)
		exit_si()
		}
}

proc zoom_out()
{
		w_clip_clear(tw)
		read_the_signal(0,Endtime,0)
		paint_the_labels()
}

proc zoom_in()
{
            z1 = get_srs(pw)
            z2 = get_srf(pw)
	    do_zoom(z1,z2)

}

proc do_a_select()
{
	 w_show_curs(pw,1,"right_arrow",0.5,0.5)
	 did_sr=mouse_select(pw)
         if (did_sr) {
	 do_zoom(Z0,Z1)
         }
#	 w_real_xor(pw,Z0,0,Z1,400)
}

proc update_files()
{
	    if (Transcribe_type @= "UPE") {
		write_timit_labels(timit_gp,upe_file,timit_file)
                  }
	    if (Transcribe_type @= "WORD") {
		write_timit_labels(timit_w,wrd_file,timit_file)
                }
}


proc add_some_tokens()
{
	add_tokens = 1
	while (add_tokens) {
		o_print("add_label","\n")
		w_show_curs(tw,1,"right_arrow",0.5,0.5)
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

proc write_tokens()
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


proc the_menu (the_choice)
{
        <<" $the_choice \n"

        show_curs(1,-1,-1,"watch")

        if ( the_choice @= "REDRAW") {
            show_curs(1,-1,-1,"cross",7,7)
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



//////////////////////////////////////////// WINDOW SETUP ////////////////////////////////////////////

wx = 0.05
wX = 0.98

# pitch window
pw = w_create(1,0)
w_resize(pw,wx,0.84,wX,0.99,1)
w_map(pw)
w_clear(pw)
w_border(pw)
w_title(pw,"pitch")

# spectrogram window
spw = w_create(1,0)
w_resize(spw,wx,0.63,wX,0.83,1)
w_map(spw)
w_clear(spw)
w_border(spw)
w_title(spw,"sgraph")

# time-amp window
tw = w_create(1,0)
w_resize(tw,wx,0.25,wX,0.62,1)
w_map(tw)
w_clear(tw)
w_border(tw)
w_title(tw,"tran")

# label window
lw = w_create(1,0)
w_resize(lw,wx,0.01,wX,0.20,1)
w_map(lw)
w_clear(lw)
w_title(lw,"label")
w_border(lw)



//////////////////////////////////////////// WINDOW OBJECTS ////////////////////////////////////////////

su_buttons(tw)
spec_buttons(spw)


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
  //o_print(display)
go_on= get_the_file()
if ( !go_on) {
exit_si()
}
w_title(tw,timit_file)

cx = 0.05
cX = 0.99
cY = 0.98
w_set_clip(pw,cx,0.1,cX,cY)
w_set_clip(tw,cx,0.15,cX,cY)
w_set_clip(spw,cx,0.25,cX,cY)
w_set_clip(lw,cx,0.1,cX,cY)

status_wo=w_set_wo(tw,"WO_BUTTON_VALUE"," ",2,0.05,0.95,0.55,0.99," ")

w_redraw_wo(tw)
w_clip_border(tw)
w_clip_border(lw)

w_redraw_wo(spw)

success= read_the_signal(file_start,0,1)


if (success <= 0) {
exit_si()
}



A=o_file("tran.lab","w")
lab_file = scat(timit_file,".phn")
guplab_file = scat(timit_file,".gup")
upe_file = scat(timit_file,".upe")
oupe_file = scat(timit_file,".oupe")
wrd_file = scat(timit_file,".wrd")
owrd_file = scat(timit_file,".owrd")
 

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

sg_file = scat(timit_file,".sg")
rms_file = scat(timit_file,".rms")
spp_file= scat(timit_file,".spp")
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

        show_curs(1,-1,-1,"spider",7,7)
	w_wo_activate(sw)

	wnu=message_wait(&MS[0],&type,&len,&time_stamp)
	l=str_scan(&MS[0],&choice)
 
        sw = wnu

        the_menu (choice)
      
  }

 STOP!
	



# FEATURES BUGS & WANTS
# W highlite selected region
# W edit token (change start-stop) - done
# W ready-made alias for WORK - done 

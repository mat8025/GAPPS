///
///  upe_procs
///


char MS[120];
float MO[10];

# mono or color
Mono = 1;

proc set_cmap()
{
/{
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
/}


 ng = 128;
 Gindex = 150  //  150 is just above our resident HTLM color map
 tgl = Gindex + ng

 SetGSmap(ng,Gindex)  // grey scale  

 return (ng);
}
//===================================
// make threaded play for long samples

proc play_the_signal(s1, s2)
{

<<"$_proc %V $s1 $s2 \n"

  change = 0;

  if ( (s1 != Olds1) || (s2 != Olds2) ) {
  change =1
  }

  Olds1 = s1
  Olds2 = s2

//write_buffer(sw,cfile,s1,s2)
//command("chmod 666 ", cfile )
//
//command("rsh hal2 audioconvert -F -i rate=16000,encoding=linear16,channels=mono  -o /mnt/hal/SPEECH/tmp/bvox /mnt/hal/SPEECH/tmp/cvox")
//

//command("chmod 666 ", bfile)
//the_file="../Vox/fac-1.16k.left.vox"
//   if (change) {
//       write_buffer(sw,the_file,s1,s2)
//    }
  //closeAudio()
  
  openAudio()

//<<"%V$Sbn $s1 $s2\n"
 
  playBuffer(dspfd, Sbn, s1, s2)
  
  //closeAudio()
}
//=====================================================

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

		while (gsr > 0)
		{
		
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

			play_the_signal(s1*Sf,s2*Sf)
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
//===============================================

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
//===============================================

proc paint_the_labels ()
{
		sWo(lwo,@penhue,RED_,@clearclip);
		sWo(two,@penhue,RED_);
		
		paint_labels(timit_p,two,1,0.75)
		paint_labels(timit_gp,two,1,0.2)

                sWo(lwo,@clearclip,@penhue,BLUE_);

                sWi(lw,@tmsg,timit_file)
		
                //text(lw,timit_file,0.85,0.85,1)
                paint_labels(timit_p,lwo,1,0.75)
                paint_labels(timit_w,lwo,0,0.5);
		paint_labels(timit_gp,lwo,1,0.2)
}
//===============================================


proc read_the_labels ()
{

reset_label_set(timit_w)
reset_label_set(timit_p)
reset_label_set(timit_gp)

 op = "VIEW";

// FIX decision window looks wierd in XGS!

// TBD op = decision_w("TRANSCRIBE","transcribe ? (word or UPE) or Just View "," WORD ", " UPE ", " VIEW ")

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
 paint_labels(timit_w,lwo,0,0.5)
}
k=read_timit_labels(timit_p,lab_file)
if (k) {
 paint_labels(timit_p,two,0,0.75)
}

if (Transcribe_type @= "UPE") {
k=read_timit_labels(timit_gp,upe_file)
}

if (Transcribe_type @= "VIEW") {
k=read_timit_labels(timit_gp,upe_file)
}


if (k) {
//setpen(tw,"blue",1)
 paint_labels(timit_gp,two,1,0.2)
 //write_timit_labels(timit_gp,oupe_file,timit_file)
}

}

//===============================================

proc paint_win_labs (xw, ttype)
{
		w_clip_clear(xw)
		w_refresh(xw)
		scale_taw(xw)
		paint_labels(ttype,xw,1,0.25)
}
//===============================================
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
  		//read_the_signal(bt,(et-bt),0)
		do_pt(lw)
		paint_the_labels()
		set_sr_times(pw,bt,et)
                show_sr(pw)
		show_curs(1,-1,-1,"cross")
}
//===============================================
proc do_plot_track (sw)
{
        rx=get_w_rs(tw,0)
        rX=get_w_rs(tw,2)
	set_w_rs(spw,0,rx)
	set_w_rs(spw,2,rX)
	pt_file="tran.spp"
	isfp =f_exist(pt_file,0, 320)
	w_clip_clear(spw)
      //  setpen(spw,"blue",1)
	plot_chan(spw,pt_file,1,1,0,5,2)
      //  setpen(spw,"red",1)
	plot_chan(spw,pt_file,0,1,0,5,2)
	set_w_rs(pw,0,rx)
	set_w_rs(pw,2,rX)
	isfp =f_exist(rms_file,0, 320)
	w_clip_clear(pw)
	plot_chan(pw,rms_file,0,1,0,5,2)
}
//===============================================

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
//===============================================




proc show_sg ()
{

	gwm_show_curs(1,-1,-1,"watch")
	ngl = set_cmap()
        rx=get_w_rs(tw,0)
        rX=get_w_rs(tw,2)
	set_w_rs(spw,0,rx)
	set_w_rs(spw,2,rX)
# assuming 16 kHZ sample frequency
	set_w_rs(spw,1,0)
	set_w_rs(spw,3,8000);
	
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
	gwm_show_curs(1,-1,-1,"cross")
}
//===============================================

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
     //   setpen(pw,"red",1)
	plot_chan(pw,rms_file,1,1,0,7)
	w_store(pw)
	show_curs(1,-1,-1,"cross")
}
//

proc do_gettok (ttype)
{
	tok = -1;
	but = 0;
        findtok = 1;
        key = -1;
        nn = 1;
	retrys = 0;
	char ckey;
	woid = -1;
	wnu = 0;
	
        while ( findtok) {

<<"click or hit key!\n";


	MO = getMouseEvent();

<<"%V$MO\n"
                        wnu = MO[0];
                        woid = MO[12];
                        but = MO[2];
		        key = MO[4];

                
		
                key = Trunc(key);

                //ckey = dec_ascii(key);
		ckey = key;
		
<<"%V$key $ckey\n";

	        if ( (but > 0) || (woid < 0)) {
		   findtok = 0;
		}

		if (ckey == 'p') {
		  findtok = 0
                }

		if (ckey == 'r') {
		  findtok = 0
                  nn = 2
                }

		if (ckey == 'l') {
		  findtok = 0
                  nn = -1
                }

		if (ckey == 'z') {
                  <<" got z \n"
                  findtok = 0;
                  woid = -1;
                }
              	
		<<"%V$but $woid  $wnu $findtok \n";
                if (MO[0] == -1 && (MO[1] == 9)) {
                   // timeout
		 if (retrys <1) {
		    findtok = 1;
		 }
		 retrys++;
 <<"$retrys %V$findtok\n"		 
                 }
		
                }

		tim = MO[7];
<<"%V$tim \n"

		if (woid == two ) {
		  <<"looking for label @ $tim\n";
			tok = search_label_time(ttype,tim,1,nn)
		}

        <<"%V $tok $wnu   $MO[3] \n";
	return (tok);
}
//======================================

proc do_delete (the_ttype)
{

		//w_show_curs(tw,1,"pirate",0.5,0.5)
		show_curs(1,-1,-1,"pirate",7,7)
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
	//	w_show_curs(tw,1,"spider",0.5,0.5)
}
//======================================
 
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
	     play_the_signal(start_t * Sf,stop_t * Sf)
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
//===================================================
 
proc play_token (the_ttype)
{
       play_tokens = 1;
       gwm_w_show_curs(tw,1,"hand",0.5,0.5);
	
	float start_t = 0.0;
	float stop_t = Endtime;
        int s1;
	int s2;
        float last_start_xor = -1;
	float last_stop_xor = -1;


      while (play_tokens) {
	<<"see hand?\n";		
        show_curs(1,-1,-1,"hand",7,7);
       
       tok = do_gettok(the_ttype);

<<"%V $tok found \n"
	if ( tok < 0 ) {
	   //w_show_curs(tw,1,"spider",0.5,0.5);
          <<"$_proc break out\n";

         break;
        }
	     lab = get_label_name(the_ttype,tok)
	     start_t = get_label_start(the_ttype,tok)
	     stop_t = get_label_stop(the_ttype,tok);
	     s1 = cast(INT_,start_t * Sf);
	     s3 = cast(INT_,stop_t * Sf);
	     s2 = stop_t * Sf;

<<"%V $lab $start_t $stop_t $s1 $s2 $s3\n";

            if (last_start_xor != -1) {
	       wrxor(two,last_start_xor,-32000,last_stop_xor,32000,GREEN_);
               last_start_xor = -1;
            }
	    
	     if (stop_t > start_t) {
	    // w_real_xor(tw,start_t,-32000,stop_t,32000)
	       wrxor(two,start_t,-32000,stop_t,32000,GREEN_);
	       last_start_xor = start_t;
	       last_stop_xor = stop_t;
	       
	       	      // wrxor(tw,start_t,-32000,stop_t,32000,BLUE);
               dt= stop_t - start_t;
	       <<"%V$dt \n"
	       if (dt < 0.5) {
                 s1 -= 2000;
		 s2 += 2000;
		 <<"extending play time \n"
               }

	     play_the_signal(s1,s2);

             mt = start_t + (stop_t-start_t)/2
	  //   w_show_curs(pw,2,"hand",mt,0)
             }
	}
      //show_curs(1,-1,-1,"cross",7,7)
         <<"$_proc play_token? done\n";
    //  w_show_curs(tw,1,"spider",0.5,0.5);
            if (last_start_xor != -1) {
	       wrxor(two,last_start_xor,-32000,last_stop_xor,32000,GREEN_);
               last_start_xor = -1;
            }
}

//==============================================================

proc show_token (the_ttype,tok)
{
	if ( tok >= 0 ) {
	     start_t = get_label_start(the_ttype,tok)
	     stop_t = get_label_stop(the_ttype,tok)
	     w_real_xor(tw,start_t,-32000,stop_t,32000)
	 }
}

//==============================================================
proc play_window()
{
     RP = wogetrscales(two);   // via PIPE msg 
     rx = RP[1]
     ry = RP[2]
     rX = RP[3]
     rY = RP[4]
     int f1 = rx * Sf;
     int f2 = rX * Sf;
     sWo(buttonwos,@update,@redraw)
     play_the_signal(f1, f2);     

}
//==============================================================



proc go_forward()
{
     
     RP = wogetrscales(two);   // via PIPE msg 
     rx = RP[1]
     ry = RP[2]
     rX = RP[3]
     rY = RP[4]
     <<"$_proc $rx $rX \n"
     rx += Fstep;
     rX += Fstep;
     sWi(tw,@redraw)
     showVox(two,rx,rX);
     showRmsZx();
    // sWo(fewo,@scales,twRx,0,twRX,300)
     do_pt(fewo)
     
     int f1 = rx * Sf;
     int f2 = rX * Sf;
     //sWo(fewo,@scales,twRx,0,twRX,300,@savescales,0)
     //play_the_signal(f1, f2);



     computeSpecandPlot(rx, rX);     
     paint_the_labels();
     sWo(buttonwos,@border,BLACK_,@redraw);

//     <<"$_proc DONE \n"
}
//===========================================================

proc go_back()
{

     RP = wogetrscales(two);   // via PIPE msg 
   //<<"%V$RP \n"
     rx = RP[1]
     ry = RP[2]
     rX = RP[3]
     rY = RP[4]
     rx -= Bstep/2;
     rX -= Bstep/2;
     <<"$_proc $rx $rX \n"
     sWi(tw,@redraw)
         //read_the_signal(frw_start,frw_dur,0)
     showVox(two,rx,rX)
     showRmsZx();
    // sWo(fewo,@scales,twRx,0,twRX,300)
     do_pt(fewo)
     computeSpecandPlot(rx, rX);     
     paint_the_labels()
     sWo(buttonwos,@border,BLACK_,@redraw);
}

//===========================================================



proc add_some_tokens()
{
	add_tokens = 1
	while (add_tokens) {
		<<"add_label\n"
		
		//w_show_curs(tw,1,"right_arrow",0.5,0.5)
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

//==============================================================
float twRx= 0.0;
float twRX= 4.0;

proc showVox( wwo, st1, st2)
{

 int s1 = st1 * Sfreq;
 int s2 = st2 * Sfreq;
            nbs = s2-s1;
<<"%V$wwo $st1 $st2  $s1 $s2 $nbs from buffer $Sbn\n"

            twRx = st1;
	    twRX = st2;
	    
          //  sWo(wwo,@scales,st1,-20000,st2,20000)
	    sWo(two,@scales,st1,-30000,st2,30000)
            sWo(lwo,@scales,st1,-3,st2,3)	    
            // position cursors
           //  sGl(co2_gl,@cursor,0,y0,0,y1)
  //          sGl(co3_gl,@cursor,10,y0,10,y1)  
            
            sWo(wwo, @redraw,@clearclip,YELLOW_)
            sWi(tw,@redraw); // DBG
            drawSignal(wwo, Sbn, s1, s2);

            axnum(wwo,-3);

             
}
//======================================================
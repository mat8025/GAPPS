//%*********************************************** 
//*  @script ootlib.asl 
//* 
//*  @comment task-planner library
//*  @release CARBON 
//*  @vers 4.1 H Hydrogen                                                  
//*  @date Tue Aug  6 06:33:35 2019 
//*  @cdate 9/17/1997 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%
///
/// 9/17/2017

DBG"%V $_DB\n"

  ntpts = 0
  Min_lat = 90.0
  Max_lat = 0.0
  Min_W = 109.0
  Max_W = 105.0

# conversion routines
  km_to_feet = 3281.0
  km_to_nm = 3281.0/6080.0
  km_to_sm = 3281.0/5280.0
  nm_to_sm = 6080.0/5280.0
  nm_to_km = 6080.0/3281.0


//DBG"%V $nm_to_km $km_to_sm  \n"

  Units = "KM"
  lat = "A"
  longit = "B"

  LegK =  0.5 * (7915.6 * 0.86838);
  //DBG" %v $LegK \n"
  //  Main_init = 0

DBG" read in unit conversions \n"

//============================================

include "tpclass"


proc getDeg (str the_ang)
    {
      str the_dir;
      float la;
      float y;
      str wd;

//DBG"in $_proc $the_ang \n"
	

    the_parts = Split(the_ang,",")

sz = Caz(the_parts);
//DBG"sz $sz $(typeof(the_parts))\n"

    //DBG"%V $the_parts[::] \n"


//FIX    float the_deg = atof(the_parts[0])

    wd = the_parts[0];
    the_deg = atof(wd);
        //DBG"%V $wd $the_deg \n"

//    float the_min = atof(the_parts[1])
    wd = the_parts[1];

    the_min = atof(wd);
        //DBG"%V $wd $the_min \n"
    //DBG"%V$the_deg $the_min \n"

      //  sz= Caz(the_min);

      //DBG" %V$sz $(typeof(the_deg)) $(Cab(the_deg))  $(Cab(the_min)) \n"

    the_dir = the_parts[2];

    y = the_min/60.0;

    la = the_deg + y;

      if ((the_dir @= "E") || (the_dir @= "S")) {
         la *= -1;
      }

//DBG"%V $la  $y  \n"
      
    return (la);
   }

//===============================//


proc get_word(str defword)
  {
  svar h

    //    DBG" %V $defword $via_keyb $via_cl \n"

      if (via_keyb) {
	// DBG"via keybd \n"
	// DBG"$defword "
        h = irs(Stat)
	  if ( h > 1) {
             sscan(Stat,&h);  
	  }
	else {
          h = defword
	    }
      }

      if (via_file) {
        h = r_file(TF)
          if ((h @= "EOF") || si_error()) {
            h = "done"
          }
      }

      //          DBG" $_cproc exit with $h \n"

    return h
 }
//==================================================
proc get_wcoors(int sw,  float rx,  float ry,float  rX,float  rY)
{
  float rs[20];
  ww= get_w_rscales(sw,&rs[0]);
  rx= rs[0]
  ry = rs[1]
  rX= rs[2]
  rY = rs[3]
  return ww
}
//==================================================


proc compute_leg(int leg)
{
    float km;

    if (leg < 0) 
          return 0

    kk = leg + 1

	    // DBG" compute %V $leg $kk \n"

    L1 = LA[leg]
    L2 = LA[kk]

	    // DBG" %V $L1 $L2 \n"

    lo1 = LO[leg]
    lo2 = LO[kk]


	    //DBG" %V $lo1 $lo2 \n"
    km = computeGCD(L1,L2,lo1,lo2);
    
    return km
}
//==================================================
proc computeGCD(float la1,float la2,float lo1,float lo2)
{
///  input lat and long degrees - GCD in km

    rL1 = d2r(la1)

    rL2 = d2r(la2)

    rlo1 = d2r(lo1)
    rlo2 = d2r(lo2)

    D= acos (sin(rL1) * sin(rL2) + cos(rL1) * cos(rL2) * cos(rlo1-rlo2));

    N = LegK * D ;

    km = N * nm_to_km;

    return km;
}

//==================================================
proc screen_dump()
{
# make it monochrome
  ff=open_laser("st.ps")
  scr_laser(tw)
  nc = get_colors()
  set_colors(2);
  DrawMap(tw)
  draw_task(tw,"red")
  laser_scr(tw)  
  ff=close_laser()
  set_colors(nc)
}
//==================================================

proc read_task(str task_file, int query)
{
    if (query) 
      task_file = navi_w("TASK_File","task file?",task_file,".tsk","TASKS")

  TF= ofr(task_file)

	//  print("tsk file ",task_file," ",TF,"\n")

    if (TF != -1) {

      ti = 0

      set_si_error(0)

        for (k = 1 ; k <= Ntp ; k += 1) {
          ff=w_set_wo_value (tw,tp_wo[k],"",1)
          w_set_wo_value (tw,ltp_wo[k],"0",1)
          tpt[k] = -1
        }

      TT = r_file(TF)

        if ( !(TT @= ""))  w_set_wo_value(tw,tclass_wo,TT)

        while (1) {

          atpt = r_file(TF)

            if ( (f_error(TF) > 0 ) || (atpt @= "EOF"))  break

//DBG"TP $atpt $ti \n"
          key[ti] = atpt
          wi = find_key(key[ti])
          if (wi == -1) break
          tpt[ti] = wi
          w_set_wo_value (tw,tp_wo[ti],key[ti],1)
          ti += 1
        }
      c_file(TF)
    }
}
//==================================================

proc write_task()
{
  tsk_file = "cfi/K_1.tsk"

  tsk_file=query_w("DATA_FILE","write to file:",tsk_file)

    if (tsk_file @= "")       return
    
  val = get_wo_value(tw,tclass_wo)

    WF=ofw(tsk_file)
    w_file(WF,val,"\n")
    if ((val @= "TRI")) {
      val = get_wo_value(tw,start_wo)

      w_file(WF,val,"\n")

        for (kk = 1 ; kk <= 3 ; kk +=1) {
          val = get_wo_value(tw,tp_wo[kk])
          w_file(WF,val,"\n")
        }
      c_file(WF)
    }

    if ((val @= "W")) {
      val = get_wo_value(tw,start_wo)

      w_file(WF,val,"\n")

        for (kk = 1 ; kk <= 4 ; kk +=1) {
          val = get_wo_value(tw,tp_wo[kk])
          w_file(WF,val,"\n")
        }
      c_file(WF)
    }

    if ((val @= "MT")) {
      val = get_wo_value(tw,start_wo)
      w_file(WF,val,"\n")
        for (kk = 1 ; kk <= 8 ; kk +=1) {
          val = get_wo_value(tw,tp_wo[kk])
            if ( ! (val @= "")) {
              w_file(WF,val,"\n")
            }
        }
      c_file(WF)
    }
}
//==================================================


proc set_task()
{
  chk_start_finish()
  set_wo_task(tw)
  total = task_dist()
#  DrawMap(tw)
  draw_task(tw,"red")
  tot_units = scat(total,Units)
  ff=w_set_wo_value (tw,td_wo,tot_units,1)
}
//==================================================

proc grid_label(int wid)
{
  ts = 0.01

# incr should set format
  float rx;
  float ry;
  float rX;
  float rY;

  sWo(wid,@penhue,BLACK_)
  
  RS= wgetrscales(wid);

//DBG"%V$RS \n"

  rx= RS[1];
  ry= RS[2];
  rX= RS[3];
  rY= RS[4];
 // DBG"%V $rx $ry $rX$rY\n"


  putMem("LongW","$rx",1)

  putMem("LongE","$rX",1)
  putMem("LatS","$ry",1)
  putMem("LatN","$rY",1)

  dx = (rX - rx );
  dy = (rY - ry );
//DBG"%V $dx $dy\n"

  x_inc = getIncr ( dx);
  y_inc = getIncr ( dy);
//DBG"%V $x_inc $y_inc \n"  
  x_inc = 0.1;
  y_inc = 0.1;
  
//DBG"%V $x_inc $y_inc \n"

    if (x_inc != 0.0 ) {
     // ticks(wid,1,rx,rX,x_inc,ts)
        if (x_inc >= 0.01) {
          axnum(wid,1,rx,rX,2*x_inc,-1.5,"3.1f")
        }
        else {
          axnum(wid,1,rx,rX,2*x_inc,-1.5,"3.1f")
        }
    }

    if ( y_inc != 0.0) {
      //ticks(wid,2,ry,rY,y_inc,ts)
      axnum(wid,2,ry,rY,2*y_inc,-2.0,"2.1f")
    }

  sWo(wid,@clipborder);
}
//==================================================

proc magnify(int w_num)
{
  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY)


  drx = (rX - rx)/4.0
  dry = (rY - ry)/4.0

  R[0] = rx +drx
  R[1] = ry +dry
  R[2] = rX -drx
  R[3] = rY -dry

  ff=show_curs(1,-1,-1,"resize")
  aw=select_real(w_num,&R[0])
  ff=show_curs(1,-1,-1,"curs_font")

    if (aw != -1) {
      xr0 = R[0]
      xr1 = R[2]
      yr0 = R[1]
      yr1 = R[3]

      xr = xr1-xr0
      set_w_rs(w_num,xr0,yr0,xr1,yr1)
      w_clip_clear(w_num)
      ff=w_redraw_wo(w_num)
      x0 = 0
    }
    w_store(w_num)
}
//==================================================

proc new_units()
{
  Units = choice_menu("Units.m")
}
//==================================================

proc new_coors(int w_num)
{
#  par_menu = "cfi/tcoors.m"
  par_menu = "tcoors.m"
  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY)


  set_menu_value(par_menu,"x0",rx)
  set_menu_value(par_menu,"x1",rX)
  set_menu_value(par_menu,"y1",rY)
  set_menu_value(par_menu,"y0",ry)



  value = table_menu(par_menu)

    if ( value == 1 ) {

      xr0= get_menu_value(par_menu,"x0")
      xr1= get_menu_value(par_menu,"x1")
      yr1= get_menu_value(par_menu,"y1")
      yr0= get_menu_value(par_menu,"y0")

      xr = xr1-xr0
      ff=set_w_rs(w_num,xr0,yr0,xr1,yr1)
      ff=w_clip_clear(w_num)
      ff=w_redraw_wo(w_num)
      x0 = 0
      DrawMap(w_num)
    }
}
//==================================================

proc zoom_to_task(int w_num, int draw)
{
 // this needs to find rectangle - just bigger than task
  // found via computetaskdistance



  ff=sWo(w_num,@scales,Max_W,Min_lat,Min_W,Max_lat)
  if (draw) {
  sWo(w_num,@clearclip,@clearpixmap)
  DrawMap(w_num)
  draw_task(w_num,"black")
  sWo(w_num,@showpixmap)
  }
}
//==================================================

proc zoom_up(int w_num)
{
  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY)

  dy = Fabs(ry-rY)/4
  ry += dy
  rY += dy
  ff=set_w_rs(w_num,rx,ry,rX,rY)
  ff=w_clip_clear(w_num)
#  ff=w_redraw_wo(w_num)
  DrawMap(w_num)
  draw_task(w_num,"red")
}
//==================================================

proc zoom_in(int w_num)
{
  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY)

  dx = Fabs(rx-rX)/4
  dy = Fabs(ry-rY)/4
  rx -= dx
  rX += dx
  ry += dy
  rY -= dy

  ff=set_w_rs(w_num,rx,ry,rX,rY)
  ff=w_clip_clear(w_num)
  ff=w_redraw_wo(w_num)
  DrawMap(w_num)
  draw_task(w_num,"red")
}
//==================================================

proc  draw_the_task ()
{
  DrawMap(tw)
  draw_task(tw,"red")
}
//==================================================

proc zoom_out(int w_num,int draw)
{
  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY)

  dx = Fabs(rx-rX)/4
  dy = Fabs(ry-rY)/4
  rx += dx
  rX -= dx
  ry -= dy
  rY += dy

  ff=set_w_rs(w_num,rx,ry,rX,rY)

  if (draw) {
  draw_the_task()
  }
}
//==================================================

proc zoom_rt(int w_num)
{
  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY)

  dx = Fabs(rx-rX)/4
  dy = Fabs(ry-rY)/4
  rX -= dx
  rx -= dx
  set_w_rs(w_num,rx,ry,rX,rY)
  w_clip_clear(w_num)
  ff=w_redraw_wo(w_num)
  DrawMap(w_num)
  draw_task(w_num,"red")
}



proc zoom_lt(int w_num)
{
  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY)

  dx = Fabs(rx-rX)/4
  dy = Fabs(ry-rY)/4
  rX += dx
  rx += dx
  ff=set_w_rs(w_num,rx,ry,rX,rY)
  ff=w_clip_clear(w_num)
  ff=w_redraw_wo(w_num)
  DrawMap(w_num)
  draw_task(w_num,"red")
}


proc reset_map()
{
  set_w_rs(tw,LongW,LatS,LongE,LatN)
  DrawMap(tw)
}


proc insert_tp(int w)
{

  ff=w_show_curs(tw,1,"right_arrow")
  ff=w_wo_activate(tw)
  wnu=message_wait(&MS[0],&type,&len)

    if (wnu == tw) {
      l = sscan(&MS[0],&c)
        if (strcmp(c ,"PKTPT",5)) {
          wtpt = spat(c,"PKTPT_",1)
          print("insert ",wtpt)
          c= "xx"
            for (i = ntpts-1 ; i >= wtpt ; i -=1) {
              tval = get_wo_value(tw,tp_wo[i])
              ff=w_set_wo_value (tw,tp_wo[i+1],tval)
            }
          ntpts++
          ff=w_show_curs(tw,1,"left_arrow")
          get_tpt(wtpt)
          set_task()
        }
    }
}

proc delete_tp(int w)
{
# get_tp

    while (1) {
      ff=w_show_curs(tw,1,"pirate")
      ff=w_wo_activate(tw)
      wnu=message_wait(&MS[0],&type,&len)

        if (wnu == tw) {
          l=str_scan(&MS[0],&c)
            if (strcmp(c ,"PKTPT",5)) {
              wtpt = spat(c,"PKTPT_",1)
              print("delete ",wtpt)
              c= "xx"
                for (i = wtpt ; i < (ntpts-1) ; i +=1) {
                  tval = get_wo_value(tw,tp_wo[i+1])
                  ff=w_set_wo_value (tw,tp_wo[i],tval)
                }
              ff=w_set_wo_value (tw,tp_wo[ntpts-1],"")
              ff=w_set_wo_value (tw,tp_wo[ntpts],"")
              ntpts--
              ff=w_set_wo_value (tw,ntp_wo,ntpts-1)
              ff=w_show_curs(tw,1,"cross")
              return
            }
        }
    }

}
//======================================//
proc delete_alltps()
{
# get_tp
                for (i = 0 ; i <ntpts ; i++) {
                  ff=w_set_wo_value (tw,tp_wo[i],"")
                  w_set_wo_value (tw,ltp_wo[i],"0",1)
                }
      w_set_wo_value (tw,finish_wo," ")
              ntpts = 1
}
//======================================//

proc get_tpt(int wtpt)
{

 int wn;
 str lab;

//DBG"bad get_tpt \n"
//  return 0;
 // get_mouse_event(&mse[0])

 // wn = mse[3]

 // if (wn == -1) return -1

  longit = mse[4]
  lat = mse[5]

  min = 10
  mkey = 0

    for (k = 0 ; k < ntp ; k++) {
      lab = Keys[k]
      dx = Fabs(longit - LO[k])
      dy = Fabs(lat - LA[k])
      dxy = dx + dy
        if (dxy < min) {
          mkey = k
          min = dxy
        }
    }

  lab = Keys[mkey]
  print("get_tpt $lab $longit $lat \n")

    if (wtpt == 0)       w_set_wo_value (tw,start_wo,lab)
    if (wtpt >=1)       w_set_wo_value (tw,tp_wo[wtpt],lab)
    if (wtpt == -1)       w_set_wo_value (tw,finish_wo,lab)

    return 1;
}
//======================================//


proc find_key(int akey)
{

    for (ak = 0 ; ak < ntp ; ak++) 
        if (Keys[ak] @= akey) return (ak)
  return (-1)
}
//======================================//

proc draw_task(int w,str col)
{
    for (i = 0 ; i < ntpts ; i++ ) {
    <<"%V$LO[tpt[i]] $LA[tpt[i]] \n"
       ff=plot_line(w,LO[tpt[i]],LA[tpt[i]],LO[tpt[i+1]],LA[tpt[i+1]],col)
    }
}
//======================================//
igc_file = "dd.igc"

proc plot_igc(int w)
{
//DBG" RECODE \n";

///  replace with
///  A=ofr(igc_file)
//   readIGG(A,latv,lngv,elev)
///  drawGline (igc)
///  cf(A)



/{/*
   a=ofr(igc_file)
   if (a == -1) {
     DBG" can't open IGC file \n"
     return
   }

      while (1) {

                         tword=r_file(a)
//DBG"$tword \n"
                         if (f_error(a) == 6) break

			 if (sele(tword,0) @= "B") {
                          igclat = sele(tword,7,8)
                          igclong = sele(tword,15,9)
                          latnum = igc_dmsd(igclat)
                          lngnum = igc_longd(igclong)
#              DBG"$igclat $latnum $igclong $lngnum\n"
                          plot_line(w,lngnum,latnum ,"blue")
			 }
 
   }
 w_store(w); 
 cf(a);
/}*/


 }
//==================================


proc set_wo_task(int w)
{
  for (k = 1 ; k <= Ntp ; k++)
    tpt[k] = -1;

  nd_tpts = 0

  start_key = get_wo_value(w,start_wo)

  tpt[nd_tpts] = find_key(start_key)


    for (k = 1 ; k <= ntpts ; k++) {

      key[k] = get_wo_value(w,tp_wo[k])

        if ( ! (key[k] @= "" )) {
          nd_tpts += 1
          tpt[nd_tpts] = find_key(key[k])
          ff=w_set_wo_value (tw,tp_wo[k],key[k],1)
        }
      w_set_wo_value (tw,ltp_wo[k],"0",1)
    }

  finish_key = get_wo_value(w,finish_wo)
}
//============================

proc chk_start_finish()
{
  val= "OB"
  val = get_wo_value(tw,tclass_wo)
  put_mem("TT",val)

    if ((val @= "TRI")) {
      val = get_wo_value(tw,start_wo)
      w_set_wo_value (tw,tp_wo[3],val)
      w_set_wo_value (tw,tp_wo[4],"")
      w_set_wo_value (tw,finish_wo,val)
      ntpts = 3
    }

    if (val @= "OB") {
      val = get_wo_value(tw,start_wo)
      w_set_wo_value (tw,tp_wo[2],val)
      w_set_wo_value (tw,tp_wo[3],"")
      w_set_wo_value (tw,finish_wo,val)
      ntpts = 2
    }

    if ((val @= "SO") ) {
      val = get_wo_value(tw,tp_wo[1])
      w_set_wo_value (tw,finish_wo,val)
      ntpts = 1
    }

    if ((val @= "DL") ) {
      val = get_wo_value(tw,tp_wo[2])
      w_set_wo_value (tw,finish_wo,val)
      ntpts = 2
    }

    if ((val @= "W") ) {
      val = get_wo_value(tw,tp_wo[4])
      w_set_wo_value (tw,finish_wo,val)
      ntpts = 4
    }

    if ((val @= "MT") ) {
      ntpts = 0
      mti = 1
      lval = ""
        while (1) {
          val = get_wo_value(tw,tp_wo[mti])
          print(val," ",mti,"\n")
            if ( (val @= "") || (val @= "NULL")) {
              break
            }
          mti++
          lval = val
          ntpts++
        }
      print("MT lval ",lval," ",ntpts,"\n")
      w_set_wo_value (tw,finish_wo,lval)
    }

  
  ff=w_set_wo_value (tw,ntp_wo,ntpts-1)

}
//============================

proc task_menu(int w)
{
<<"$_proc   $w\n"

  ur_c=choicemenu("MENUS/task_opts.m")
<<"chose $ur_c \n"
          if (ur_c @= "zoom_to_task") {
            zoom_to_task(mapwo,1)
            return
          }

    if (ur_c @= "save") {
       save_image(w,"task_pic")
    }
    
    if (ur_c @= "magnify") {
      magnify(w)
      DrawMap(w)
    }

    if (ur_c @= "plot_igc") {
       plot_igc(w)
    }

    if (ur_c @= "delete_tp") {
      delete_tp(w)
      set_task()
    }

    if (ur_c @= "delete_all") {
      delete_alltps()
      DrawMap(w)
     // w_set_wo_value (tw,td_wo,"0",1)
    }

    if (ur_c @= "insert_tp") {
      insert_tp(w)
      set_task()
    }

    if (ur_c @= "coors") {
      new_coors(w)
    }
    
    if (ur_c @= "units") {
      new_units()
      set_task()
    }

    if (ur_c @= "set") {
      DrawMap(w)
      draw_task(w,"red")
      total = task_dist()
      //w_set_wo_value (tw,td_wo,total,1)
    }

    if (ur_c @= "reset") reset_map()

    if (ur_c @= "read_task") {
      read_task(tfile,1)
      set_task()
      zoom_to_task(tw,0)
      zoom_out(tw,0)
      zoom_out(tw,1)
    }

    if (ur_c @= "screen_print") {
      screen_dump()
      }
      
    if (ur_c @= "write_task") {
      write_task()
    }
    
    if (ur_c @= "get_start") {
      ff=w_show_curs(tw,1,"left_arrow")
      get_tpt(0)
      set_task()
    }

    if ( scmp(ur_c,"get_tpt_",8)) {
      wtpt = spat(c,"get_tpt_",1)
   //   ff=w_show_curs(tw,1,"left_arrow")
      get_tpt(wtpt)
      set_task()
    }

    if (ur_c @= "get_finish") {
      ff=w_show_curs(tw,1,"left_arrow")
      get_tpt(-1)
      set_task()
    }
}

# the_task
# start - (tp1,...) - finish
//=====================================//
proc task_dist()
{
  t_d = 0

    for (i = 0 ; i < ntpts ; i++) {
#      print(i," ",tpt[i]," ",tpt[i+1],"\n")
   if (i == 0) {
       as = tpt[i]
      Max_W = LO[as] 
      Min_W = LO[as] 
      Max_lat = LA[as]
      Min_lat = LA[as]
    }
      the_leg = compute_leg2(tpt[i],tpt[i+1])
        if (Units @= "NM")           the_leg *= km_to_nm
        if (the_leg > 0) {
          ff=w_set_wo_value (tw,ltp_wo[i+1],Fround(the_leg,2),1)
          t_d += the_leg
        }
      print(i," t_d ",t_d,"\n")
    }

 print(Min_lat," ",Max_lat," ",Max_W," ",Min_W,"\n")

  t_d = Fround(t_d,2)
  return (t_d)
}
//============================================

proc compute_leg2(int t_1,int t_2)
{

  leg = t_1

  kk = t_2

  L1 = LA[leg]
  L2 = LA[kk]

  if (L1 < Min_lat)      Min_lat = L1
  if (L1 > Max_lat)      Max_lat = L1
  if (L2 > Max_lat)      Max_lat = L2
  if (L2 < Min_lat)      Min_lat = L2

    //  DBG"lats are $L1 $L2 \n"

  lo1 = LO[t_1]
  lo2 = LO[t_2]

  if (lo1 < Min_W)      Min_W = lo1
  if (lo1 > Max_W)      Max_W = lo1

    //  DBG"longs are $lo1 $lo2 \n"

  rL1 = d2r(L1)
  rL2 = d2r(L2)

  rlo1 = d2r(lo1)
  rlo2 = d2r(lo2)

  D= Sin(rL1) * Sin(rL2) + Cos(rL1) * Cos(rL2) * Cos(rlo1-rlo2)
			  //  DBG" $D $(typeof(D)) \n"
  D= Acos(D)

  dD= r2d(D)

			  //print(D," ",dD,"\n")

  N = 0.5 * (7915.6 * 0.86838) * D;

  print("dist = ",N," nm","\n")

  sm = N * nm_to_sm

  print("dist = ",sm," sm","\n")

  km = N * nm_to_km

    //DBG"dist = km $km \n"

  return (km)
}
//============================//
proc setup_legs()
{
    suk = 0
    print("setup_legs ",wox," ",woy," ",woX," ",woY)
    tp_name = scat("PKTPT_",suk)
    gtp_wo[suk]=w_set_wo(tw,WBS,tp_name,1,wogx,woy,wogX,woY)

  for (suk = 1 ; suk <= Ntp ; suk++) {
    woY = woy - ysp
    woy = woY - ht
    tp_name = scat("TP:",suk)
    tp_wo[suk] = w_set_wo(tw,WBV,tp_name,1,wox,woy,woX,woY)
    tp_name = scat("LEG_",suk)
    ltp_wo[suk]=w_set_wo(tw,WSV,tp_name,1,wolx,woy,wolX,woY)
    tp_name = scat("PKTPT_",suk)
    gtp_wo[suk]=w_set_wo(tw,WBS,tp_name,1,wogx,woy,wogX,woY)
  }

}
//=====================================//

proc the_menu (str c)
{

          if (c @= "zoom_out") {
            zoom_out(tw,1)
            return
          }

          if (c @= "zoom_to_task") {
            zoom_to_task(tw,1)
            return
          }

          if (c @= "zoom_up") return  zoom_up(tw)
          if (c @= "zoom_in") return  zoom_in(tw)
          if (c @= "zoom_rt") return   zoom_rt(tw)
          if (c @= "zoom_lt") return zoom_lt(tw)
          if (c @= "TASK_MENU" ) return  task_menu(tw)
          if (c @= "REDRAW" ) return


          if ( c @= "TYPE" ) {
            val=""
            l=sscan(&MS[5],&val)
            chk_start_finish()
            set_wo_task(mapwo)
            total = task_dist()
            DrawMap(tw)
            draw_task(tw,"blue")
            w_set_wo_value (tw,td_wo,total,1)
            return
          }

   if ( (c @= "Start:") || (strcmp(c,"TP",2) ==1) || (c @= "Finish:") ) {
            w_clip_clear(tw)
            w_clip_border(tw)
            set_wo_task(tw)
            chk_start_finish()
            total = task_dist()
            DrawMap(tw)
            draw_task(tw,"red")
            w_set_wo_value (tw,td_wo,total,1)
            return
          }

          if ( scmp(c,"PKTPT",5) ) {
            ff=w_show_curs(tw,1,"left_arrow")
            wtpt = spat(c,"PKTPT_",1)
            print("get ",wtpt)
            ret = get_tpt(wtpt)
            if (ret == -1) return
            DrawMap(tw)
            set_task()
            return 
          }
}
//=====================
proc conv_lng(str lng)
  {

  lngdeg = spat(lng,",",-1,1)

  lngmin = spat(lng,",",1,1)

  WE = spat(lngmin,",",1,-1)
  lngmin = spat(lngmin,",","<",">")
  lngmin = lngmin/60.00

  lngdec = lngdeg + lngmin + 0.00001

    if (WE @= "W") {
         lngdec *= -1.0
	   }
  }
//=========================

proc conv_lat (str lat)
  {

 latdeg = spat(lat,",",-1,1)

 latmin = spat(lat,",",1,1)

 NS = spat(latmin,",",1,-1)

 latmin = spat(latmin,",","<",">")
 latmin = latmin/60.00
 latdec = latdeg + latmin

  }
//=========================

proc nearest (int tp)
{
  // compute distance from tp to others
  // if less than D
  // print

}
//====================//


proc spin()
{
 static int k = 0

 i = k % 4
  if (i == 0)
      DBG" \\ \r "
  else if (i == 1)
      DBG" | \r "
  else if (i == 2)
      DBG" -- \r "
  else
      DBG" / \r "
 k++
}
//===============================================



float IGCLONG[];
float IGCLAT[];
float IGCELE[];
float IGCTIM[];


proc IGC_Read(str igc_file)
{

DBG"%V $igc_file \n"

   T=fineTime();

   a=ofr(igc_file);

   if (a == -1) {
     DBG" can't open IGC file $igc_file\n"
     return 0;
   }

    ntps =ReadIGC(a,IGCTIM,IGCLAT,IGCLONG,IGCELE);


  //  IGCLONG = -1 * IGCLONG;
DBG"read $ntps from $igc_file \n"

   dt=fineTimeSince(T);
<<[_DB]"$_proc took $(dt/1000000.0) secs \n"
    cf(a);
   return ntps;
}
//========================

int Ntp = 0;

proc DrawMap(int wo)
{
//DBG"$_proc %V $wo\n"

  int msl;
  float lat;
  float longi;
  str mlab;
  int is_an_airport = 0;

      sWo(wo,@clearpixmap,@clipborder);

//DBG"$mlab $(typeof(mlab))\n";
//DBG"%V $Ntp\n"
    for (k = 0 ; k < Ntp ; k++) {

        is_an_airport = Wtp[k]->GetTA();

        mlab = Wtp[k]->Place;
//DBG"%V $k $mlab\n"
        if (!is_an_airport) {
         mlab = slower(mlab)
       }

//DBG"$k %V $is_an_airport  $mlab $(typeof(mlab))\n";
	
        msl = Wtp[k]->Alt;

        lat = Wtp[k]->Ladeg;

        longi = Wtp[k]->Longdeg;

//DBG"%V $k $mlab $msl $lat $longi $Wtp[k]->Ladeg\n"

        if ( msl > 7000) {
             Text(wo,mlab,longi,lat,0,0,1,RED_)
	     //DBG"above 7K $mlab\n"
        }
        else {
            if ( msl > 5000) {
             Text(wo,mlab,longi,lat,0,0,1,BLUE_)
	     	    // DBG"above 5K $mlab\n"
            }
            else {
	    	   //  DBG"below 5K $mlab\n"
              Text(wo,mlab,longi,lat,0,0,1,GREEN_)
            }
        }
    }

      sWo(wo,@showpixmap,@clipborder);
    
        grid_label(wo)

}
//====================================================
str TaskType = "MT";

proc DrawTask(int w,str col)
{
   if ( Task_update) {
    TaskDistance();
    <<"$_proc  $TaskType $col $Nlegs \n"
    }
    if ( (TaskType @= "OAR")   || (TaskType @= "SO")) {

      plot(w,@line,Tasktp[0]->Longdeg,Tasktp[0]->Ladeg,Tasktp[1]->Longdeg,Tasktp[1]->Ladeg,col)

    }
    else {

    for (i = 0 ; i < (Nlegs-1) ; i++ ) { 

   <<"$i %V $w, $Tasktp[i]->Longdeg $Tasktp[i]->Ladeg,$Tasktp[i+1]->Longdeg,$Tasktp[i+1]->Ladeg, $col \n "

      plot(w,@line,Tasktp[i]->Longdeg,Tasktp[i]->Ladeg,Tasktp[i+1]->Longdeg,Tasktp[i+1]->Ladeg,col)

    }

    }

 sWo(w,@showpixmap,@clipborder);
    

}
//=============================================


proc PickTP(str atarg,  int witp) 
{
///
/// 

    int kk;

    Fseek(A,0,0)
DBG" looking for  $atarg \n"
    i=Fsearch(A,atarg,-1,1,0)
    if (i != -1) {
     kk= witp;
DBG" %V $kk $witp $(typeof(witp)) \n"
    Tasktp[kk]->cltpt = atarg;
    nwr = Tasktp[kk]->Read(A)
DBG" found $atarg $kk $witp $nwr\n"

   }
}
//=============================================


proc ClosestTP (float longx, float laty)
{
///
 T=fineTime();
 float mintp = 30;
 int mkey = -1;
 float ctp_lat;

int k = 3;
//DBG"%V $Wtp[0]->Ladeg \n"
//DBG"%V $Wtp[k]->Ladeg \n"
    ctp_lat = Wtp[k]->Ladeg;
//DBG"%V $ctp_lat \n"
    for (k = 0 ; k < Ntp ; k++) {

        ctp_lat =   Wtp[k]->Ladeg;

        longi = Wtp[k]->Longdeg;

        dx = Fabs(longx - longi);
        dy = Fabs(laty - ctp_lat);
        dxy = dx + dy;

        if (dxy < mintp) {
          mkey = k;
          mintp = dxy;
//DBG"%V $Wtp[k]->Ladeg $ctp_lat $longi $laty $longx  $dx $dy $Wtp[k]->Place \n"
      }

    }

   if (mkey != -1) {
DBG" found $mkey \n"
     Wtp[mkey]->Print()
   }

    dt=fineTimeSince(T);
DBG"$_proc took $(dt/1000000.0) secs \n"
     return  mkey;
}
//=============================================

proc ClosestLand(float longx,float laty)
{
 float mintp = 18000;
 int mkey = -1;
 int isairport = 0;
 float sa 
 float longa
 float lata
 float msl;
 float mkm;
 float ght;
 float sa;
 
  longa = longx;
  lata = laty;

    for (k = 0 ; k < Ntp ; k++) {

         isairport = Wtp[k]->GetTA();
//DBG"$_proc %V $isairport \n"
         if (isairport) { 
                msl = Wtp[k]->Alt;
                mkm = HowFar(lata,longa, Wtp[k]->Ladeg,Wtp[k]->Longdeg)
                ght = (mkm * km_to_feet) / LoD

//FIX_PARSE_ERROR                sa = Wtp[k]->Alt + ght + 2000


                sa = msl + ght + 2000

//DBG" $k $mkm $ght $sa \n"

          if (sa < mintp) {
          mkey = k
          mintp = sa
          }
      }

    }


   if (mkey != -1) {
DBG" found $mkey \n"
      Wtp[mkey]->Print()
   }
   return  mkey
}
//=============================================


proc PickaTP(int itaskp)
{

// 
// use current lat,long to place curs
//
  int ret = 0;
//DBG" get task pt $itaskp \n"

  float rx;
  float ry;

  rx = MidLong;
  ry = MidLat;

           MouseCursor("left", mapwo, rx, ry);  // TBC


    Text(vptxt,"Pick a TP for the task ",0,0.05,1)

    sWi(vp,@tmsg,"Pick a TP for the task ")

         eventWait();

          gsync()

          sleep(0.2)

          ntp = ClosestTP(_erx,_ery);

          MouseCursor("hand");

        if (ntp >= 0) {

             Wtp[ntp]->Print()

             nval = Wtp[ntp]->GetPlace()

DBG" found %V $ntp $nval  $itaskp\n"

            Tasktp[itaskp]->cltpt = nval;
            Tasktp[itaskp]->Place = nval;	    
            //Tasktp[itaskp]->Ladeg = Wtp[ntp]->Ladeg;   // TBF
            la = Wtp[ntp]->Ladeg;
            Tasktp[itaskp]->Ladeg = la;	    
             vala = Wtp[ntp]->Longdeg;
             //Tasktp[itaskp]->Longdeg = Wtp[ntp]->Longdeg; // TBF
	     Tasktp[itaskp]->Longdeg = vala;
	    
	    Tasktp[itaskp]->Alt = Wtp[ntp]->Alt;	    



            Fseek(A,0,0);
            i=Fsearch(A,nval,-1,1,0)

DBG" %v $i \n"

//int kk = itaskp;

           if (i != -1) {

DBG" setting TASK_PT $itaskp  to $nval \n" 
            // position at tp file entry -- why not search Wtp for entry
	    
   //         nwr = Tasktp[itaskp]->Read(A)
DBG"$itaskp  TaskPT \n"
            Tasktp[itaskp]->Print();

            ret = 1;
            }
      }
      
      return ret;
}
//=============================================//

proc get_tpt(int wtpt)
{
 int wn;
 float rx;
 float ry;

  E->waitForMsg();
  E->getEventRXY(rx,ry);
  woid = E->getEventWoid();

  //get_mouse_event(&mse[0])
  
  if (woid != mapwo) {
     return 0;
  }

  longit = rx;
  lat =  ry;

  min = 10;
  mkey = 0;

    for (k = 0 ; k < ntp ; k++) {
      lab = Keys[k]
      dx = Fabs(longit - LO[k])
      dy = Fabs(lat - LA[k])
      dxy = dx + dy
        if (dxy < min) {
          mkey = k
          min = dxy
        }
    }

    return 1
}
//=============================================


proc ComputeTC(int j, int k)
{
    float km = 0.0

    L1 = Wtp[j]->Ladeg

    L2 = Wtp[k]->Ladeg

    lo1 = Wtp[j]->Longdeg

    lo2 = Wtp[k]->Longdeg

      tc = trueCourse(L1,lo1,L2,lo2)
      //DBG"%V$tc \n"
      return tc
}
//===========================//


proc ComputeTPD(int j, int k)
{

    float km = 0.0;

//DBG" $_proc %V $j $k \n"

    L1 = Wtp[j]->Ladeg;

    L2 = Wtp[k]->Ladeg;

  //  DBG" %V $L1 $L2 \n"
    //DBG" %I $k $Wtp[k]->Ladeg \n"
    //DBG" %I $j $Wtp[j]->Ladeg \n"

    lo1 = Wtp[j]->Longdeg;

    lo2 = Wtp[k]->Longdeg;

/{/*
  // DBG"%V $lo1 $lo2 \n"
    rL2 = d2r(L2)
    rL1 = d2r(L1)

   // DBG" %V $rL1 $rL2 \n"

    rlo1 = d2r(lo1);
    rlo2 = d2r(lo2);

    sL1 = sin(rL1);
    cL2 = cos(rL2);

//DBG"%V $sL1 $cL2 \n"

    D= acos (sin(rL1) * sin(rL2) + cos(rL1) * cos(rL2) * cos(rlo1-rlo2));

    N = LegK * D

    km1 = N * nm_to_km
/}*/

    km2 = Gcd(L1,lo1 , L2, lo2 );

//DBG"%V $km1 $km2\n"

    km = km2;
  //  DBG" %V $D  $LegK $N  $nm_to_km $km\n" ;


    return km
 }
//====================================//



#

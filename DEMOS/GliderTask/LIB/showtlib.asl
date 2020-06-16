#! /usr/local/GASP/bin/asl
#/* -*- c -*- */
# "$Id: showtlib.asl,v 1.2 1997/12/07 03:48:51 mark Exp mark $"

if (Main_init) {

  DB = 0
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

  Units = "KM"
  lat = "A"
  longit = "B"

  LegK =  0.5 * (7915.6 * 0.86838)
   //<<" %v $LegK \n"
  Main_init = 0
}



proc get_word( defword)
  {

  svar h

    //    <<" %V $defword $via_keyb $via_cl \n"

      if (via_keyb) {
 <<"via keybd \n"
        <<"$defword "
        h = irs(Stat)
        if ( h > 1) sscan(Stat,&h);  
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

      //          <<" $_cproc exit with $h \n"

    return h
 }

proc get_wcoors(sw,  rx,  ry,  rX,  rY)
{
  float rs[20];
  ww= get_w_rscales(sw,&rs[0])
  rx= rs[0]
  ry = rs[1]
  rX= rs[2]
  rY = rs[3]
  return ww
}

//FIX proc compute_leg(int leg)


proc compute_leg( leg)
{

  //    <<" $_cproc  $leg \n"

    //    double D

    float km

    if (leg < 0) 
          return 0


    kk = leg + 1

	    //<<" compute %V $leg $kk \n"

    L1 = LA[leg]
    L2 = LA[kk]

	    //<<" %V $L1 $L2 \n"

    lo1 = LO[leg]
    lo2 = LO[kk]

	    //<<" %V $lo1 $lo2 \n"

    rL1 = d2r(L1)
    rL2 = d2r(L2)

    rlo1 = d2r(lo1)
    rlo2 = d2r(lo2)

    D= acos (sin(rL1) * sin(rL2) + cos(rL1) * cos(rL2) * cos(rlo1-rlo2))

      //    		       <<"2 %v $D $(typeof(D)) \n"

	    //      <<" %V $D  $LegK   $nm_to_km\n"

    N = LegK * D

    km = N * nm_to_km

	    //   <<" %V  $N $km $(typeof(km))\n"

    return km
}

proc screen_dump()
{
# make it monochrome
  ff=open_laser("st.ps")
  scr_laser(tw)
  nc = get_colors()
  set_colors(2)
  draw_map(tw)
  draw_task(tw,"red")
  laser_scr(tw)  
  ff=close_laser()
  set_colors(nc)
}


proc read_task(task_file, query)
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

	   //          <<"TP $atpt $ti \n"
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

proc set_task()
{
  chk_start_finish()
  set_wo_task(tw)
  total = task_dist()
#  draw_map(tw)
  draw_task(tw,"red")
  tot_units = scat(total,Units)
  ff=w_set_wo_value (tw,td_wo,tot_units,1)
}


proc grid_label(w_num)
{
  ts = 0.01

# incr should set format
  ff=setpen(w_num,"black",1)
  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY)

  put_mem("LongW",rx)
  put_mem("LongE",rX)
  put_mem("LatS",ry)
  put_mem("LatN",rY)

  dx = (rX - rx )
  dy = (rY - ry )

  x_inc = get_incr ( dx)
  y_inc = get_incr ( dy)

    if (x_inc != 0.0 ) {
      ticks(w_num,1,rx,rX,x_inc,ts)
        if (x_inc >= 0.01) {
          axnum(w_num,1,rx,rX,2*x_inc,-3.0,"3.1f")
        }
        else {
          axnum(w_num,1,rx,rX,2*x_inc,-3.0,"3.1f")
        }
    }

    if ( y_inc != 0.0) {
      ticks(w_num,2,ry,rY,y_inc,ts)
      axnum(w_num,2,ry,rY,2*y_inc,-2.0,"2.1f")
    }

  w_clip_border(w_num)
}


proc magnify(w_num)
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


proc new_units()
{
  Units = choice_menu("Units.m")
}


proc new_coors(w_num)
{
#  par_menu = "cfi/tcoors.m"
  par_menu = "tcoors.m"
  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY)


  set_menu_value(par_menu,"x0",rx)
  set_menu_value(par_menu,"x1",rX)
  set_menu_value(par_menu,"y1",rY)
  set_menu_value(par_menu,"y0",ry)

  db_print(DB," new_coors")

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
      draw_map(w_num)
    }
}


proc zoom_to_task(w_num, draw)
{

  ff=set_w_rs(w_num,Max_W,Min_lat,Min_W,Max_lat)
  if (draw) {
  ff=w_clip_clear(w_num)
  draw_map(w_num)
  draw_task(w_num,"red")
  }
}


proc zoom_up(w_num)
{
  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY)

  dy = Fabs(ry-rY)/4
  ry += dy
  rY += dy
  ff=set_w_rs(w_num,rx,ry,rX,rY)
  ff=w_clip_clear(w_num)
#  ff=w_redraw_wo(w_num)
  draw_map(w_num)
  draw_task(w_num,"red")
}

proc zoom_in(w_num)
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
  draw_map(w_num)
  draw_task(w_num,"red")
}

proc  draw_the_task ()
{
  ff=w_clip_clear(tw)
  draw_map(tw)
  draw_task(tw,"red")
}

proc zoom_out(w_num,draw)
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


proc zoom_rt(w_num)
{
  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY)

  dx = Fabs(rx-rX)/4
  dy = Fabs(ry-rY)/4
  rX -= dx
  rx -= dx
  set_w_rs(w_num,rx,ry,rX,rY)
  w_clip_clear(w_num)
  ff=w_redraw_wo(w_num)
  draw_map(w_num)
  draw_task(w_num,"red")
}



proc zoom_lt(w_num)
{
  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY)

  dx = Fabs(rx-rX)/4
  dy = Fabs(ry-rY)/4
  rX += dx
  rx += dx
  ff=set_w_rs(w_num,rx,ry,rX,rY)
  ff=w_clip_clear(w_num)
  ff=w_redraw_wo(w_num)
  draw_map(w_num)
  draw_task(w_num,"red")
}


proc reset_map()
{
  set_w_rs(tw,LongW,LatS,LongE,LatN)
  draw_map(tw)
}


proc insert_tp(w)
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

proc delete_tp(w)
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


proc get_tpt(wtpt)
{
 float mse[20]
 int wn
  get_mouse_event(&mse[0])

  wn = mse[3]

  if (wn == -1) return -1

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

    return 1
}


proc draw_map(w)
{
  w_clip_clear(w)
  ff=w_clip_border(w)

    for (k = 0 ; k < ntp ; k++) {
      lab = Keys[k]
# print(lab,"\n")

        if (MSL[k] > 7000) {
          w_text(w,lab,LO[k],LA[k],0,0,1,"red")
        }
        else {
            if (MSL[k] > 5000) w_text(w,lab,LO[k],LA[k],0,0,1,"blue")
            else w_text(w,lab,LO[k],LA[k],0,0,1,"green")
        }
    }

  ff=w_clip_border(w)
  ts = 0.01
  grid_label(w)
#  ff=w_redraw_wo(w)

}


proc find_key(akey)
{

    for (ak = 0 ; ak < ntp ; ak++) 
        if (Keys[ak] @= akey) return (ak)
  return (-1)
}


proc draw_task(w,col)
{
    for (i = 0 ; i < ntpts ; i++ ) 
    ff=plot_line(w,LO[tpt[i]],LA[tpt[i]],LO[tpt[i+1]],LA[tpt[i+1]],col)
}

igc_file = "dd.igc"

proc plot_igc(w)
{

 a=ofr(igc_file)
   if (a == -1) {
     <<" can't open IGC file \n"
     return
   }

 while (1) {

                         tword=r_file(a)
#<<"$tword \n"
                         if (f_error(a) == 6) break

			 if (sele(tword,0) @= "B") {
                          igclat = sele(tword,7,8)
                          igclong = sele(tword,15,9)
                          lnum = igc_dmsd(igclat)
                          lngnum = igc_longd(igclong)
#              <<"$igclat $lnum $igclong $lngnum\n"
                          plot_line(w,lngnum,lnum ,"blue")
			 }
 
   }
    w_store(w) 
 cf(a)
 }



proc set_wo_task(w)
{
  for (k = 1 ; k <= Ntp ; k++) tpt[k] = -1

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


proc task_menu(w)
{
  ur_c=choice_menu("task_opts.m")

          if (ur_c @= "zoom_to_task") {
            zoom_to_task(tw,1)
            return
          }

    if (ur_c @= "save")       save_image(w,"task_pic")

    if (ur_c @= "magnify") {
      magnify(w)
      draw_map(w)
    }

    if (ur_c @= "plot_igc")        plot_igc(w)

    if (ur_c @= "delete_tp") {
      delete_tp(w)
      set_task()
    }

    if (ur_c @= "delete_all") {
      delete_alltps()
      draw_map(w)
      w_set_wo_value (tw,td_wo,"0",1)
    }

    if (ur_c @= "insert_tp") {
      insert_tp(w)
      set_task()
    }

    if (ur_c @= "coors") new_coors(w)

    if (ur_c @= "units") {
      new_units()
      set_task()
    }

    if (ur_c @= "set") {
      draw_map(w)
      draw_task(w,"red")
      total = task_dist()
      w_set_wo_value (tw,td_wo,total,1)
    }

    if (ur_c @= "reset") reset_map()

    if (ur_c @= "read_task") {
      read_task(tfile,1)
      set_task()
      zoom_to_task(tw,0)
      zoom_out(tw,0)
      zoom_out(tw,1)
    }

    if (ur_c @= "screen_print") screen_dump()
    if (ur_c @= "write_task") write_task()

    if (ur_c @= "get_start") {
      ff=w_show_curs(tw,1,"left_arrow")
      get_tpt(0)
      set_task()
    }

    if ( scmp(ur_c,"get_tpt_",8)) {
      wtpt = spat(c,"get_tpt_",1)
      ff=w_show_curs(tw,1,"left_arrow")
      get_tpt(wtpt)
      set_task()
    }

    if (ur_c @= "get_finish") {
      ff=w_show_curs(tw,1,"left_arrow")
      get_tpt(-1)
      set_task()
    }
}

# conversion routines

proc get_dmsd (the_ang)
{

  //      <<" $_cproc %v $the_ang \n"
    //float the_deg =  0.0
    //float the_min = 0.1
    //svar the_parts
    //svar the_dir

    //<<"%V $the_deg $(typeof(the_deg)) $the_min $(typeof(the_min)) $the_dir\n"

    the_parts = Split(the_ang,",")

      //<<" $the_parts \n"

    the_deg = atof(the_parts[0])

    the_min = atof(the_parts[1])

    sz= Caz(the_min)

    the_dir = the_parts[2]
      //<<" %v $the_dir \n"
   
      //    <<" %v $the_ang \n"
      //        <<"%V $the_deg $(typeof(the_deg)) $the_min $sz $(typeof(the_min)) $the_dir \n"

    //    float la

    //    float y

    y = the_min/60.0

    sz= Caz(y)

      //<<"%v $y  $(typeof(y))    $sz\n"

    la = the_deg + y

    sz= Caz(la)

      //<<"%v $la  $(typeof(la))    $sz\n"

      if (the_dir @= "E") {
         la *= -1
      }

    if (the_dir @= "S") {
           la *= -1
	     }

    //     <<" %V $la  $y $(typeof(la)) \n"
    ;
 return (la)
 
  }


proc dat_dmsd (the_ang)
{

    <<" $_cproc %v $the_ang \n"

    nang = ssub(the_ang,":",".")

    the_parts = Split(nang,".")

    the_deg = the_parts[0]

    the_min = the_parts[1]

    the_cdir = the_parts[2]

    sl= slen(the_cdir) 
    sli = sl -1

    the_dir = the_cdir{sli}

  //     <<" %V $the_deg $the_min $sl  $the_cdir $the_dir\n"

    float la
    float y = the_min/60.0

    la = the_deg + y

    if (the_dir @= "E") la *= -1

    if (the_dir @= "S") la *= -1

      //      <<" %v $la  $y $(typeof(la)) \n"

    return (la)
  }




proc igc_dmsd (sivar the_ang)
  {
    the_deg = the_min = 0.0
    the_deg = sele(the_ang,0,2)
    the_min = sele(the_ang,2,2)
      //<<" $the_deg $the_min \n"
    f = sele(the_ang,4,3)
   the_min += (f/1000)
    la = the_deg + the_min/60.0
    the_dir = sele(the_ang,8)
    if (the_dir @= "S") la *= -1
    return (la)
  }

proc igc_longd (sivar the_ang)
  {
   the_deg = the_min = 0.0
    the_deg = sele(the_ang,0,3)
    the_min = sele(the_ang,3,2)
    f = sele(the_ang,5,3)
   the_min += (f/1000)
    la = the_deg + the_min/60.0
    the_dir = sele(the_ang,9)
    if (the_dir @= "E")) la *= -1
    return (la)
  }


# the_task
# start - (tp1,...) - finish

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


proc compute_leg2(t_1,t_2)
{
  leg = t_1

  kk = t_2

  L1 = LA[leg]
  L2 = LA[kk]

  if (L1 < Min_lat)      Min_lat = L1
  if (L1 > Max_lat)      Max_lat = L1
  if (L2 > Max_lat)      Max_lat = L2
  if (L2 < Min_lat)      Min_lat = L2

    //  <<"lats are $L1 $L2 \n"

  lo1 = LO[t_1]
  lo2 = LO[t_2]

  if (lo1 < Min_W)      Min_W = lo1
  if (lo1 > Max_W)      Max_W = lo1

    //  <<"longs are $lo1 $lo2 \n"

  rL1 = d2r(L1)
  rL2 = d2r(L2)

  rlo1 = d2r(lo1)
  rlo2 = d2r(lo2)

  D= Sin(rL1) * Sin(rL2) + Cos(rL1) * Cos(rL2) * Cos(rlo1-rlo2)
			  //  <<" $D $(typeof(D)) \n"
  D= Acos(D)

  dD= r2d(D)

			  //print(D," ",dD,"\n")

  N = 0.5 * (7915.6 * 0.86838) * D

  print("dist = ",N," nm","\n")

  sm = N * nm_to_sm

print("dist = ",sm," sm","\n")

  km = N * nm_to_km

    //<<"dist = km $km \n"

  return (km)
}

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


proc the_menu (c)
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
            set_wo_task(tw)
            total = task_dist()
            draw_map(tw)
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
            draw_map(tw)
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
            draw_map(tw)
            set_task()
            return 
          }
}

proc conv_lng( lng)
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


proc conv_lat (lat)
  {

 latdeg = spat(lat,",",-1,1)

 latmin = spat(lat,",",1,1)

 NS = spat(latmin,",",1,-1)

 latmin = spat(latmin,",","<",">")
 latmin = latmin/60.00
 latdec = latdeg + latmin

  }


proc nearest (tp)
{
  // compute distance from tp to others
  // if less than D
  // print
}
//============================
proc pickaTP( wtp)
{
<<" click and get nearest tp!\n"
    return 0;
}
//============================

proc spin()
{
 static int k = 0

 i = k % 4
  if (i == 0)
      <<" \\ \r "
  else if (i == 1)
      <<" | \r "
  else if (i == 2)
      <<" -- \r "
  else
      <<" / \r "
 k++
}


//<<" DONE reading showtlib !\n"


#

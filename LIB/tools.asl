#! /usr/local/GASP/bin/asl
#/* -*- c -*- */
# "$Id: tools.asl,v 1.2 1999/09/26 22:57:12 mark Exp mark $"
# tools library functions

    Myname = get_uname()
    gssys = gev("GS_SYS")
    Machine = get_arch()
    Np = 2

      xx = CheckGwm()

<<" GRAPHIC !! $xx \n" 

   if (CheckGwm()) {

     <<" GRAPHIC !! $xx \n"

    Np = get_planes()

    Status_wo = -1
    Status_win = -1

    Wplay = Myname
    S_display=gev("HOSTDISPLAY")

    if (S_display @= "")     S_display=gev("DISPLAY")

    Display=spat(S_display,":")

    if (Display @= "") Display=Myname

			 //    <<" $Myname system dir $gssys $Machine planes $Np  $Display\n" 
# default window size

    Sx = 1024
    Sy = 600

			 if (CheckGwm()) {
			   Sx = get_sx()
			   Sy = get_sy()
                         }

    Defwx = Sx/6
    DefwX = Sx/6 * 5
    Defwy = Sy/6
    DefwY = Sy/6 * 4

    Mono = (Np <= 4) 

    Ngl = 64
    Gindex = 16
    Fkgrey = 0

# Ngl = set_cmap(16)

      if (Mono) {
        white = "white"
        blue = "white"
        red = "white"
        green = "white"
        orange = "white"
        yellow = "white"
        Fkgrey = 1
        Ngl = 2
      }
      else {
        white = "white"
        black = "black"
        blue = "blue"
        red = "red"
        green = "green"
        orange = "orange"
        yellow = "yellow"
      }

}


proc tools_menu(mname)
{
  
  :ys=choice_menu(mname)
    if (strcmp(:ys,"ask_user",8)) {
      xx = spat(:ys,"ask_user_",1,-1)
      xx = query_w("VALUE","enter value:",xx)
      :ys = xx
    }
  return (:ys)
}


proc commentary(phrase)
{
    if (Status_wo > -1) ff=wo_setvalue(Status_win,Status_wo,phrase)
    else <<"$phrase\n"
}


proc create_gw(type)
{
  float Rw[10]
  w1=W_Create(type,0)
  ff=show_curs(1,-1,-1,"resize")
  Rw[0] = Defwx
  Rw[1] = Defwy
  Rw[2] = DefwX
  Rw[3] = DefwY
  select_box(&Rw[0])
  ff=show_curs(1,-1,-1,"curs_font")
  wx = Rw[0]
  wy = Rw[1]
  wX = Rw[2]
  wY = Rw[3]
  ff=w_resize(w1,wx,wy,wX,wY)
  w_init(w1)
  w_set_clip(w1,0.15,0.1,0.90,0.95)
  W_SetRS(w1,0,0,1,1)
  ff=W_ClearClip(w1)
  <<"created window wid $w1\n"
  return w1
}


proc set_statuswo (win)
{
  swo=w_set_wo(win,"WO_BUTTON_VALUE"," Status: ",3,.02,0.92,0.40,0.99,"")
  return swo
}


proc show_xy (w)
{
# use mouse read x,y coors and print
# esc - escape

    while(1) {

      ff=w_show_curs(w,1,"hand")
      MST=GetMouseEvent()
      button = MST[0]
        if (button == 2) {
          break
        }

      x = MST[4]
      wn = Fround(MST[3],0)

      y = MST[5]
        if (wn == -1) {
          break
        }
      title =get_title_wid(wn)
      ff=wo_setvalue(wn,t1_wo,x)
      commentary(" x $x y $y")
    }
  ff=w_show_curs(w,1,"gumby",0.5,0.5)
}

proc show_sg (sgw, the_sg_file, upper_y)
{
  ff=W_ClearClip(sgw)
  w_border(sgw)


    if (fe(the_sg_file) == -1) {
      comment= " file $the_sg_file  not found"
      commentary(comment)
      return
    }

  show_curs(1,-1,-1,"watch")

  rs=w_GetRS(tw)

<<" $rs \n"

  rx=rs[1]
  rX=rs[3]

  w_SetRS(sgw,0,rx)

  if (rX <= 0) rX = 2

  w_SetRS(sgw,2,rX)
  w_SetRS(sgw,1,0)
  ff=w_SetRS(sgw,3,upper_y)

  intpx = 2
  min_v = 10
  max_v = 90

  <<"$Ngl $Gindex $Fkgrey \n"

  err=d_image(sgw,the_sg_file,Fkgrey,Ngl,Gindex,min_v,max_v,1,intpx,0,0,0)
  w_store(sgw)
  ff=show_curs(1,-1,-1,"cross")
}


// FIX proc scope -  DOESN't see exit for this!!

//proc stop(){set_si_error(1);exit_si();}

proc do_exit(ew)
{

  ff=show_curs(1,-1,-1,"pirate",7,7)
  op = choice_menu("exit.m")
  ff=show_curs(1,-1,-1,"cross",7,7)
    if (op @= "Yes") {
      ff=w_delete(ew)
      stop()
    }
  return 0
}


proc draw_axis (w_num)
{
  grid_label (w_num,0.05)
}


proc grid_label (w_num,ts)
{
<<" $cproc $w_num $ts \n"
  axis_label(w_num,ts, 3.0, 2.0)
}


proc axis_label(w_num,ts,offx,offy)
{
# incr should set format
<<" $cproc $w_num $ts $offx $offy\n"

  float rs[10]
  rs= w_GetRS(w_num)

  if (rs[0] == -1) return
 
  rx= rs[1] 
  ry = rs[2]
  rX= rs[3]    
  rY = rs[4]

  dx = (rX - rx )
  dy = (rY - ry )

  x_inc = get_incr (dx)
  y_inc = get_incr (dy)

<<" axis_label $x_inc $y_inc \n"

    if (x_inc != 0.0 ) {
         ticks(w_num,1,rx,rX,x_inc,ts)
        if (x_inc >= 0.5) 
          axnum(w_num,1,rx,rX,2*x_inc,offx,"g")
        else 
          axnum(w_num,1,rx,rX,2*x_inc,offx,"1.2f")
    }

    if ( y_inc != 0.0) {
        ticks(w_num,2,ry,rY,y_inc,ts)

        if  (y_inc >= 0.5) 
                axnum(w_num,2,ry,rY,2.0*y_inc,offy,"g")
        else 
                axnum(w_num,2,ry,rY,2.0*y_inc,offy,"1.2f")

        <<"doing y $y_inc \n"

    }
  W_ClipBorder(w_num)

}


proc label_yaxis(w_num,ts,offy)
{
# incr should set format
  ff=setpen(w_num,"black",1)

  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY)

  dy = (rY - ry )
    if ( dy <= 0) return
    
  y_inc = get_incr ( dy)

    if ( y_inc != 0.0) {
      ticks(w_num,2,ry,rY,y_inc,ts)
      axnum(w_num,2,ry,rY,2*y_inc,offy,"g")
    }
  W_ClipBorder(w_num)
}


proc mem_prompt (dflt,pat,ps)
{
  ascii prompt = "$ps"
  i= CheckMem(pat)
    if ( i ) {
      ans = GetMem(pat)
      dflt = ans
    }
    else 
      ans = dflt
    
  ans=query_w("QUERY",prompt,ans)
  PutMem(pat,ans)
  return (ans)
}


proc scale_taw(awin, do_axnum)
{

   rs=w_GetRS(awin)
<<" $rs \n"
  :rx= rs[1]
  :rX= rs[3]

  :dx = rX - rx

  if (dx == 0.0) return 0

  :x_inc = get_incr(dx)

  :x2 = x_inc

 <<"scale_taw x_inc $x_inc $rx $rX  $dx\n"

# label at x_inc "whole" intervals

  x0 = rx / x_inc + 0.5
  x0 = Round ( x0) * x_inc
  x1 = rX / x_inc + 0.5
  x1 = Round (x1) * x_inc

  ticks(awin,1,x0,x1,x2,0.07)
  ticks(awin,3,x0,x1,x2,0.07)

  W_ClipBorder(awin)

    if (do_axnum) {
        if (x2 > 1) {
            if (x1 > x0) 
              ff=axnum(awin,1,x0,x1,2*x2,-2.0,"g")
        }
        else 
          ff=axnum(awin,1,x0,x1,2*x2,-2.0,"4.2f")
    }
  return x_inc
}

proc w_mcb(aw)
{
  W_Map(aw)
  W_Clear(aw)
  W_Border(aw)
}

proc set_cmap(ng)
{
  <<"%v $Np %v$Gindex \n"

    if ( Np > 2 ) {
      Fkgrey = 0
      rainbow()
    }

    if ( Np >= 4) 
      Gindex = 8
    else {
        if (ng >= 16) {
          Gindex = 2
          ng = 12
        }
        if (ng == 8) 
          Gindex = 8
    }

    SetGSmap(ng,Gindex)

  return (ng)
}


proc draw_taw(tw,reg)
{
  a =1
  w_SetRS(tw,1,-32000)
  w_SetRS(tw,3,32000)

  W_ClearClip(tw)

  W_ClipBorder(tw)

    if ( reg == -1 ) 
      draw_signal(tw)
    else 
      draw_signal(tw,reg)

    if ( a > 0 ) 
      scale_taw(tw,1)
      w_store(tw)
}


proc test_waw(wn,flag)
{
# get user window attributes
  i= get_uwat(wn)
  i = oct_dec(i)
  y = oct_dec(flag)
# test for axis bit
  ax = ( i & y )
  return (ax)
}

# this should be duplicated in the app library
# specific for the windows invloved
# or have array of windows active for scr_laser & laser_scr

proc laser_setup()
{
  commentary("to laser")
  scr_laser(lw)
  scr_laser(pw)
  scr_laser(Spw)
  scr_laser(tw)
  open_laser(pic_name)
}


proc screen_print()
{

  laser == "ON"
  laser_setup()
  redraw_screen()
  ff=close_laser()
  ff=laser_scr(tw)
  ff=laser_scr(lw)
  ff=laser_scr(pw)
  ff=laser_scr(Spw)

# AMEND NEXT LINE TO SEND POSTSCRIPT FILE TO PRINTER
# command("cat " ,pic_name, " | ","lp -op -s")
  laser == "OFF"
  wo_redraw(tw)
  commentary("finish laser")
}



proc get_startstop(sw, float s1, float s2)
{
  rs = w_GetRS(sw)

<<" $cproc $rs \n"

    if (rs[0] == -1) {
       s1 = -1
       s2 = -1
       return -1
    }

  <<" ${rs[1]} ${rs[3]} \n"

  s1= rs[1]
  s2= rs[3]

  <<"%v $s1 $s2 \n"  

  return sw
}

proc get_wcoors(sw, float rx, float ry, float rX, float rY)
{
  rs = w_GetRS(sw)

  <<" $rs \n"
 
   if (rs[0] == -1) {
       rx = -1
       ry = -1
       rX = -1
       rY = -1
       return -1
    }
 
<<" $rs[1] \n"
  rx = rs[1]
<<" $rx \n"
<<" $rs[2] \n"
  ry = rs[2]
<<" $ry \n"
  rX = rs[3]
  rY = rs[4]

  <<"$cproc $rx $ry $rX $rY $(typeof(rx))\n"

  return rs[0]
}

proc is_in(sivar a, sivar b)
{
 spat(a,b,1,1,&match)
 return match
}


# end of lib functions


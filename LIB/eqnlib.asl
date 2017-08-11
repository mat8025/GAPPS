#/* -*- c -*- */
# "$Id: eqnlib.g,v 1.1 1999/09/15 16:12:08 mark Exp mark $"

proc plot_data()
{
  w_clip_border(w)
  sym_nu = "diamond"
  size = 3.0
  ff=setpen(w,"red")
  for(i=0; i<np; i += 2) 
  plot_symbol(w,XI[i],YI[i],sym_nu,size,"blue")

}

proc plot_xy(n, as)
{
  i = v_maxmin(&YI[0],&YS[0],n)
  <<"$YS[0] $YS[1] \n"
  rx= get_w_rs(w,0)
  rX= get_w_rs(w,2)
  if (as)   w_SetRS(w,rx,YS[1],rX,YS[0])
  ff=setpen(w,"black")
  vv_draw(w,&XI[0],&YI[0],n)
}

proc set_eqn()
{
  the_eqn="A"
  ncb=get_wo_text(w,eqn_wo,&EQ[0],120)
  sscan(&EQ[0],&:e)
<<"$ncb $e %s$EQ[0]\n"
  wc_file(E,&EQ[0],ncb)
  return k
}

proc do_state()
{
  the_eqn="A"
  ncb=get_wo_text(w,state_wo,&ST[0],256)
  set_si_error(0)
<<"$ST[0]\n"
  k=sistate(&ST[0])
  return k
}


proc pos_axis(w1)
{
  rx= get_w_rs(w1,0)
  if (rx < 0) w_SetRS(w1,0,0.0)
}

proc neg_pos(w1)
{
  rX= get_w_rs(w1,2)
  rx = -1 * rX
  w_SetRS(w1,0,rx)
}

proc compute_eqn(w1)
{
  rx= get_w_rs(w1,0)
  rX= get_w_rs(w1,2)
  dx = (rX - rx)
  xinc = dx/200.0
  i = 0
    set_si_error(0)
    for (x = rx ; x <= rX ; x += xinc) {
      sistate(&EQ[0])
	if (! si_error()){
      XI[i] = x
      YI[i] = y
      w_file(E,"$x $y \n")
<<"$i $x $y\n"
      i++
	}
	else {
<<"FPE $x $(si_error())\n"
    set_si_error(0)
      }
    }
<<"done compute %s$EQ[0] nvals $i\n"
  return i
}

proc do_spline(np)
{
  npo = np * 2
  float df = (XI[np-1] - XI[0]) / (npo *1.0)
  v_set(&XO[0],XI[0],df,npo+1)
  c_spline(&XI[0],&YI[0],np,&XO[0],&YO[0],npo+1)
  ff=setpen(w,"green")
  vv_draw(w,&XO[0],&YO[0],npo+1)
}


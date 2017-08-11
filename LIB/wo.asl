#/* -*- c -*- */
# "$Id: wo.g,v 1.1 1999/09/15 16:12:08 mark Exp mark $"

  if (Main_init) {

    WTB = "WO_TITLE_BUT"
    WTXTB = "WO_TEXT_BOX"
    WBV = "WO_BUTTON_VALUE"
    WBN = "WO_BUTTON_NAME"
    WBS = "WO_BUTTON_SYM"
    WMDD = "WO_MENU_DROP_DOWN"
    WSV = "WO_SHOW_VALUE_ONLY"
    WSVB = "WO_SHOW_VALUE_BOTTOM"
    WONOFF = "ONOFF"

    Wo_width = 0.15
    Wo_height = 0.15
    Wo_row_x = 0.01

    Wo_y1 = 0.99
    Wo_y0 = Wo_y1 - Wo_height
    Wo_x0 = Wo_row_x
    Wo_x1 = Wo_x0 + Wo_width

    Wo_xs = 0.05
    Wo_ys = 0.05
    fntsz = "medium"
  }


proc get_rcs_id()
{
 sivar fn 

 fn = get_script()

 af=ofr(fn)

 n = 0
 i = 0
 nl = 0
 mat = 0
 rem = 0

 version = "0.0"

 s = "0.0"

 s[5] = "0.0"

 while (1) {

 n=r_words(af,s)

     if (n == -1) break

 nl++

 if (nl > 5) 
      break

 if (n >= 2) {

  spat(s[1],"Id:",1,1,&mat,&rem)

   <<" $s[1] $mat $s[3] $n\n"

   if (mat == 1 ) {    
    <<" version = $s[3] \n"
    version = s[3]
    break
    }

  }

 }


  cf(af)

<<" done sipw $fn returning version  $version \n"

  return (version)

    }


proc spi_w(title)
{

 spiw =  get_spi_wid()

 ver =  get_rcs_id()

 the_ver=scat(title,ver)

 << "$title $the_ver $(Typeof(&ver))\n"

  setpen(spiw,"blue")

  w_title(spiw,the_ver,1)
  w_store(spiw)
  w_xor(spiw,1)
  w_redraw(spiw)

  return spiw 

}

proc reset_wo_xy()
{
    Wo_width = 0.15
    Wo_height = 0.15
    Wo_row_x = 0.01
    Wo_y1 = 0.99
    Wo_y0 = Wo_y1 - Wo_height
    Wo_x0 = Wo_row_x
    Wo_x1 = Wo_x0 + Wo_width
    Wo_xs = Wo_width/3
    Wo_ys = Wo_height/3
    fntsz = "medium"
}

proc set_wo_width(w)
{
  Wo_width = w
  Wo_x1 = Wo_x0 + Wo_width
}


proc set_wo_height(h)
{
  Wo_height = h
  Wo_y0 = Wo_y1 - Wo_height
}


proc tab_wo()
{
  Wo_x0 = Wo_x1 + Wo_xs
  Wo_x1 = Wo_x0 + Wo_width
}


proc skip_tab(n)
{
  for (i = 0 ; i < n ; i++ ) 
  tab_wo()
}

proc new_row_wo()
{
  Wo_x0 = Wo_row_x
  Wo_x1 = Wo_x0 + Wo_width
  Wo_y1 = Wo_y0 - Wo_ys
  Wo_y0 = Wo_y1 - Wo_height
}


proc skip_row(n)
{
 for (i = 0 ; i < n ; i++ ) {
  Wo_y1 = Wo_y0 - Wo_ys
  Wo_y0 = Wo_y1 - Wo_height
 }
}


proc topleft_menu_wo(vp)
{
  wo_id=w_set_wo(vp,2,"MAIN_MENU",2,0.01,0.88,0.1,0.95)
  <<" %v$wo_id\n"
  return wo_id
}


proc name_value_wo(vp,name,val)
{
  wo_id=w_set_wo(vp,WBV,name,1,Wo_x0,Wo_y0,Wo_x1,Wo_y1,val)
  return wo_id
}

proc name_wo(vp,name)
{
  wo_id=w_set_wo(vp,WBN,name,1,Wo_x0,Wo_y0,Wo_x1,Wo_y1,0)
  return wo_id
}

proc add_tool_wo(vp,name,symbol)
{
    id=w_set_wo(vp,2,name,2,Wo_x0,0.88,Wo_x1,0.95,3,"green",fntsz,"red",symbol)
    return id
}

proc create_vp()
{
  vp=w_create(0,0)
  w_resize(vp,0.05,0.05,0.95,0.95,-1)
  w_set_clip(vp,0.17,0.15,0.77,0.90)
  w_SetRS(vp,0,0,1,1)
  w_map(vp)
  return (vp)
}




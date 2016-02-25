//   generic ? plot one col against others

opendll("plot")

y_label = "ALT FT"
x_label = "RANGE-NM"

//setdebug(1)


proc redraw_fig()
{

      setGwindow(aw,@redraw)
//      setGwob(grwo,@border,@clipborder,@save,@color,BLACK,@axnum,2,@axnum,1)
      setGwob(grwo,@border,@clipborder,@save,@color,BLACK,@axnum,2,@axnum,1)
      setGwob(err_wo,@border,@clipborder,@save,@color,BLACK,@axnum,2,@axnum,1)

      setGwob(grwo,@clearpixmap)
      
      DrawGline(err_gl)
      DrawGline(err_raw_gl)
//      plotWosymbol(err_wo,20,0,"diamond",5,RED,0)

      setGwob(grwo,@border,@clipborder,@color,BLACK,@axnum,2,@axnum,1,@usescales,0)

      plotline(err_wo,0,0,120,0, BLUE)  

      DrawGline(prgl) // array of glines --- those with invalid id's not processed

      setGwob(grwo,@textf,x_label, 0.5,-0.1,0,0,BLACK)
      setGwob(grwo,@textf,y_label, -0.1,0.5,0,90,BLACK)
      setGwob(err_wo,@textf,"Error Ft", -0.1,0.1,0,90,BLACK)
      setGwob(err_wo,@textf,x_label, 0.5,-0.1,0,0, BLACK)

      setGwob(grwo,@textf,fn, 0.1,1.1,0,0,BLUE)

     setGwob(grwo,@border,@showpixmap,@clipborder)
     setGwob(err_wo,@border,@showpixmap,@clipborder)
     Text(aw,fntit,0.05,0.05,1)


///////////// 
// make up drawGlineKey(key_wo, glvec )
// array of gline keys into key_wo vertically tiled
/{
     setGwob(key_wo,@border,@clipborder,@clear)
     plotWosymbol(key_wo,0.12,0.8,"triangle",15,ORANGE,1)
     plotWosymbol(key_wo,0.12,0.6,"diamond",15,YELLOW,1)
     plotWosymbol(key_wo,0.12,0.4,4,15,BLUE,1)
     plotWosymbol(key_wo,0.12,0.2,"inverted",15,GREEN,1)

     setGwob(key_wo,@border,@showpixmap)
     Text(key_wo,"raw_top",0.22,0.8,1)
     Text(key_wo,"sqshy_top",0.22,0.6,1)
     Text(key_wo,"sqshy_mid",0.22,0.4,1)
     Text(key_wo,"sqshy_bot",0.22,0.2,1)
/}
///////
     setGwob(key2_wo,@border,@clear,@save)
     setGwob(key2_wo,@keygline,prgl)
     setGwob(key2_wo,@showpixmap)

     setGwob(err_key_wo,@keygline,errgl)
     setGwob(err_key_wo,@showpixmap)

     //setGwob(key2_wo,@keygline,prgl)

}

// get args


   fn = _clarg[1]


// read in csv data


  A= ofr (fn)

  if (A == -1) {

       stop("can't open $fn !\n")
  }

  fntit = sele(spat(fn,"CAL",0,-1),0,-4)
<<"Using $fntit \n"
  pfname = "${fntit}.ps"
  

  ///////////////////////////////////   CL_args //////////////////////////////////////


  na = argc()  // how many command line args

  ka = 2  // first is file


  while ( ka < na ) {
  
    key = _clarg[ka] ; ka++
    val = _clarg[ka] ; ka++
//<<"$ka $key $val\n" 

    if (key @= "ylabel") {
        y_label = val
    }
    if (key @= "xlabel") {
        x_label = val
    }

  }

<<"DONE ARGS $na $ka \n"


  ////////////////////////////////////////////////////////////////////////////////////



  hdr = readline(A)

<<"$hdr \n"

 // hdr->split(',')
 hdr = split(hdr,',')

<<"$hdr \n"

  R = ReadRecord(A,@type,FLOAT,@del,',')


<<"$R\n"


     dmn = Cab(R)

nrows = dmn[0]
ncols = dmn[1]

<<"%V$nrows $ncols\n"

<<"%V$sz $dmn\n"

sz = Caz(R)

// check # cols
  YV = R[::][3]
  YRV = R[::][2]

  Redimn(YV)
  Redimn(YRV)

  sz = Caz(YV)
<<"ysz $sz \n"

  // if want to exclude neg and 0
  MM= Stats(YV,">",0)
  // but we don't
  MM= Stats(YV)

  nsz = sz -1

<<"%V6.4f${YV[0:nsz]} \n"

<<"%6.2f$(typeof(MM)) $MM \n"

// setup scaling

      ymin = MM[1] - 2*MM[4]

 //     ymax = MM[1] + 5*MM[4]

      ymax = MM[6]

////////////////////////////////////////////////////
//  which col to use as Xvec?
//  typically first 0?

  XV = R[::][1]
    
      <<"%V$xmin $xmax \n"
  XMM = Stats(XV)

  xmin = XMM[5]

  xmax = XMM[6]

  xrange = fabs(xmax-xmin)
 
  xpad=xrange * 0.05


<<" %V$ymin $ymax \n" 
<<" %V$xmin $xmax \n" 


/////////////////////////////////////////////////




    k = 2
    clr = 2
// creates a copy of values in input matrix column
    while (k < ncols) {
      nyc = "ic_$k"
      //v= R[::][k]
      $nyc = R[::][k]
      y = $nyc
      b = Cab($nyc)

<<"$k  $b\n"
     
      k++
    }

b = Cab(ic_2)
<<"$b\n"

<<"\\\\\\\\\\\n"

 redimn(ic_2)
<<"%(10,, ,\n)6.1f$ic_2 \n"

<<"\\\\\\\\\\\n"


/{
<<"$ic_3 \n"
<<"$ic_4 \n"
<<"$ic_5 \n"
/}


  Graphic = CheckGwm()
<<"%V$Graphic \n"



  if (!Graphic) {
    Xgm = spawnGwm()
  }

   aslw = asl_w("PLOT_Y")

   si_pause(3)

// Window
  
   aw= CreateGwindow(@title,"BEAM-CAL",@scales,0,0,1,1,@savescales,0)




<<" CGW $aw \n"

    SetGwindow(aw,@resize,0.02,0.02,0.98,0.98,0)
    SetGwindow(aw,@drawon)
    SetGwindow(aw,@clip,0.05,0.05,0.95,0.95)

  // GraphWo


   grwo=createGWOB(aw,@GRAPH,@resize,0.05,0.4,0.96,0.98,@name,"PXY",@color,"white")

<<"$grwo \n"

   err_wo=createGWOB(aw,@GRAPH,@resize,0.05,0.1,0.96,0.35,@name,"ERR",@color,"white")



  // key_wo=createGWOB(aw,@GRAPH,@resize,0.91,0.7,0.98,0.9,@name,"KEY",@color,"white")
  // setGwob(key_wo,@scales,0,0,1,1,@drawon,@pixmapon)

   key2_wo = createGWOB(aw,@GRAPH,@resize,0.85,0.7,0.94,0.9,@name,"KEY",@color,"white")

   setGwob(key2_wo,@scales,0,0,1,1,@pixmapon,@save)

   err_key_wo = createGWOB(aw,@GRAPH,@resize,0.85,0.2,0.94,0.32,@name,"KEY",@color,"white")

   setGwob(err_key_wo,@scales,0,0,1,1,@pixmapon,@save)

  //////////////////////////////////////////////////////////////////////////////////

 
    dmn = Cab(YV)
<<"$dmn\n"

    target_alt = YV[-1]  // get last value -- which is very close to truth

<<"%V$target_alt\n"

// actually lets get it from the file-name WX

 t_alt = spat(spat(fntit,"WX",1),"kft",-1)

// t_alt = spat(fntit,"WX",1)

<<"%V$t_alt \n"

// t_alt = spat(t_alt,"kft",-1)

//<<"%V$t_alt \n"

   target_alt = atof(t_alt)
   target_alt *= 1000

<<"%V$target_alt \n"

    YV -= target_alt
    YRV -= target_alt

/{
    for (i =0; i <=nsz ; i++) {
       //YV[i] = YV[i] - target_alt
<<"$i $YV[i] \n"
    }
/}

     sym_sz = 1.3

int errgl[2]

     err_gl=CreateGline("wid",err_wo,@type,"XY",@xvec,XV,@yvec,YV,@color, RED,@usescales,0)
     setGline(err_gl,@name,"sq_error", @ltype,"symbol","diamond",@symsize,sym_sz,@symhue,"pink",@usescales,0)
     errgl[0] = err_gl

//<<"%V$err_gl \n"

     err_raw_gl=CreateGline("wid",err_wo,@type,"XY",@xvec,XV,@yvec,YRV,@color, RED,@usescales,0)
     setGline(err_raw_gl, @name,"raw_error",@ltype,"symbol","cross",@symsize,sym_sz,@symhue,"brown",@usescales,0)
     errgl[1] = err_raw_gl
     DrawGline(err_gl)

     setgwob(grwo,@drawon,@pixmapon,@clip,0.1,0.2,0.86,0.9,@scales,0,0,120,60000)
     setgwob(err_wo,@drawon,@pixmapon,@clip,0.1,0.2,0.86,0.9,@scales,0,-10000,120,30000)

//<<"%V$err_wo \n"

     setGwob(grwo,@scales,0,0,120,60000)

     setGwob(grwo,@border,@clipborder,@save,@color,BLACK,@axnum,2,@axnum,1)
     setGwob(err_wo,@border,@clipborder,@save,@color,BLACK,@axnum,2,@axnum,1)
     setGwob(key2_wo,@border,@clear,@texthue,BLACK,@save)
     setGwob(err_key_wo,@clipborder,@clear,@texthue,BLACK,@save)


int prgl[ncols]


    prgl = -1 ;// so all invalid till set
    k = 2
    clr = 3

// creates a copy of values in input matrix column

    s_num = 1

    while (k < ncols) {
      nyc = "ic_$k"
      $nyc = R[::][k]

//<<"$k $nyc \n"

      redimn($nyc)
      prgl[k]=CreateGline("wid",grwo,@type,"XY",@xvec,XV,@yvec,$nyc,@color, clr)
      setGline( prgl[k], @ltype,"symbol",s_num,@name,hdr[k],@symsize,sym_sz,@symhue,clr,@usescales,0)

//<<"gline $k $prgl[k] \n"

      k++
      s_num++
      clr++
    }


// FIX symbols only if pixmap


     DrawGline(prgl) // array of glines --- those with invalid id's not processed


     redraw_fig()


include "event"

Event E


 redraw_fig()

  int km = 0
  while (1) {


      E->waitForMsg()

     <<"$km $E->keyw \n"
         km++
       if ((E->keyw @= "REDRAW") || (E->keyw @= "RESIZE")) {
          
          redraw_fig()
      }

     if ( (E->keyw @= "PRINT") ) {
          openLaser("${fntit}.ps")
          //scr_laser(aw)
          gsync()
          redraw_fig()
          CloseLaser()
          //laser_scr(aw)
          gsync()
          
          si_pause(1)
          //<<" cat $pfname | lpr "
          !!"pstopnm $pfname -stdout | pnmtopng > ${fntit}.png "

          <<"PRINT DONE $fntit\n"
    }

          if ( (E->keyw @= "EXIT") ) {
            <<"got exit from XGS\n"
          break
          }

      si_pause(1)
  }


stop!
/* 
 *  @script plotchart.asl                                               
 * 
 *  @comment show igc track on sectional                                
 *  @release Beryllium                                                  
 *  @vers 1.4 Be Beryllium [asl 6.4.54 C-Be-Xe]                         
 *  @date 07/30/2022 09:34:59                                           
 *  @cdate 09/20/2021                                                   
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2022 -->                               
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                  


Str Use_= " Demo  of show igc track on sectional ";

#define ASL 1



#include "debug"

  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

   allowErrors(-1); 

  chkIn(_dblevel)

#include "gevent.asl"
#include "tbqrd.asl"


fname = _clarg[1];

int cval;
uint CM[];  // cpp make dynamic?
///
///
///
/*
float IGCLONG[];
float IGCLAT[];
float IGCELE[];
float IGCTIM[];
// check why we can't use SIV arrays?
*/

 Vec<float> IGCLONG(7000);

  Vec<float> IGCLAT(7000);

  Vec<float> IGCELE(7000);

  Vec<float> IGCTIM(7000);


int IGC_Read(Str& igc_file)
{

<<"%V $igc_file \n"

   T=fineTime();

   a=ofr(igc_file);

  <<"%V $a\n";

   if (a == -1) {
     <<" can't open IGC file $igc_file\n";
     return 0;
   }

    ntps =ReadIGC(a,IGCTIM,IGCLAT,IGCLONG,IGCELE);

    IGCELE *= 3.280839 ;

  //  IGCLONG = -1 * IGCLONG;
<<"read $ntps from $igc_file \n"

   dt=fineTimeSince(T);
<<"$_proc took $(dt/1000000.0) secs \n"
    cf(a);
   return ntps;
}
//========================

void goEast()
{
<<"Heading East\n"
   sec_col +=  scols/2;
   wlng -= dlng/2
   elng -= dlng/2
<<"$wlng  $elng\n"

}
//========================


void goWest()
{
<<"Heading West\n"
   sec_col -=  scols/2;
   wlng += dlng/2
   elng += dlng/2
   if (sec_col <0) {
       sec_col = 0; // west edge

  }
<<"$wlng  $elng\n"
}
//========================
void goNorth()
{
<<"Heading North\n"

       sec_row += srows/2;
       if (sec_row > drows) {
           sec_row = drows - srows;
       }
       else {
          nlat += dlat/2;
          slat += dlat/2;	  


       }
<<"$slat  $nlat\n"
}
//========================

void goSouth()
{
<<"Heading South\n"

       sec_row -= srows/2;
       if (sec_row < 0) {
           sec_row =0;
       }
      else {
          nlat -= dlat/2;
          slat -= dlat/2;	  
      }
<<"$slat  $nlat\n"
}
//========================
  //sdb(1,_~pline,_~trace);


int use_cpix = 1; // waht is this??

 sec_row =   0;
 sec_col =  0;

// igcfn = getArgStr();

   slat = 35.0;
   nlat = 42.0;
   wlng = 110.0;
   elng =  105.0 ;


Str igcfn = "spk.igc";

<<"%V $igcfn \n"

// igcfn.pinfo();



  Ntpts= IGC_Read(igcfn);

  int  midpt = Ntpts /2;

<<" read igc $Ntpts \n"

<<" $IGCLONG[0:20] \n"

<<" $IGCLAT[0:20] \n"

<<" $IGCTIM[0:20] \n"

  m20 =(midpt+20)
//<<" $IGCLAT[midpt:(midpt+20):] \n"

//<<" $IGCLAT[midpt:m20:] \n"
//<<" $IGCLONG[midpt:m20] \n"

   cmp_name = "${fname}.cmp";

  if (use_cpix) {
     //AF= ofr("den103.cmp")
     AF= ofr(cmp_name)
   }
 else {
   // AF= ofr("den103.dat")
    AF= ofr("${fname}.dat")
    CF= ofw("new.cmp")
  }

  if (AF == -1) {
   <<"error open $cmp_name\n";
    exit();
  }
<<"$AF $cmp_name\n";


 //AF= ofr("chey97.dat")
// 

 //BF= ofw("den103c.dat")

uint PH[3];

int nir=vread(AF,PH,3,UINT_);


int npix = PH[0];
int drows = PH[2];
int dcols = PH[1];

<<"%V $npix $drows $dcols \n"

// hdr for tiff npix rows cols

uchar CPIX[>10000];  // make dynamic ? - cpp

/*
nir=vread(AF,CPIX,3000,UCHAR_);
<<"%V $nir - just 3?\n";
<<"%V $CPIX[000:3000] \n";

nir=vread(AF,CPIX,3000,UCHAR_);
<<"%V $nir - just 3?\n";
<<"%V $CPIX[2000:3000] \n";
nir=vread(AF,CPIX,3000,UCHAR_);
<<"%V $nir - just 3?\n";
<<"%V $CPIX[0:3000] \n";


*/



openDll("image");

uint SPIX[];



map_name = "cmap_${fname}";

<<"$fname $map_name \n"


 A= ofr(map_name);

 
 CM= readRecordToArray(A,_RTYPE,UINT_);

 sz= Caz(CM);
 cmb = Cab(CM)
 
 <<"%V $sz $cmb\n"



 nc = cmb[0] ;

  <<"CM $CM[::][::] \n"
<<"\n"

<<" $CM[4][::] \n"



CM.pinfo();mo


#include "graphic"


 rainbow();
// CMAP

 int ngl = 256;
 int cmi = 64  ; // above our basic colors

//cmi = 6;

 int cindex = cmi;


 set_gsmap(ngl,cmi);




uint hexw = 0;
float dr = 1.0/256.0;
//dr *= 2;
for (i=0; i< nc; i++) {

   hexw= CM[i][1];

   redc = ((hexw & 0x00ff0000) >> 16)
   greenc = ((hexw & 0x0000ff00)   >> 8)
   bluec = (hexw & 0x000000ff)

  redv = redc * dr;
  greenv = greenc *dr;
  bluev = bluec *dr;
 if ((redv > 0.0) || (greenv > 0.0) || (bluev > 0.0)) {
 <<"$i $cindex $hexw $redc $greenc $bluec $redv $greenv $bluev\n"

}

//<<"$i $cindex $hexw \n"
//   setRGB(cindex,hexw,0);

 // setRGB(cindex,redv,greenv,bluev);
  setRGB(cindex,bluev,greenv,redv);

 //setRGB(cindex,greenv,bluev,redv);
   
    cindex++;
  //redv += dr; greenv -= dr; bluev += dr/2.0;

}



/// import cmap for chart
/// setup cmap

///  get raster file of chart color pixel
///  pull out row/col ( 512 x 512) section  

/// plot section

// want this to contain a 512X512 image -- so that plus borders and title
  


     vp =  cWi("PIC_WINDOW");

     sWi(_WOID,vp,_WRESIZE,wbox(0.01,0.01,0.9,0.95,0));


// again must be greater the 512x512 plus the borders
 
// picwo=cWo(vp,_GRAPH,_name,"Pic",_color,PINK_,_resize,40,20,1840,820,1,_flush)

   picwo=cWo(vp,WO_GRAPH_);
   sWo(_WOID,picwo,_WNAME,"PIC",_WCOLOR,PINK_,_WRESIZE,wbox(40,20,1840,820,1));

// set the clip to be 512x512 --- clipborder has to be on pixel outside of this!

 sWo(_WOID,picwo,_WBORDER,BLACK_,_WDRAW,ON_,_WFONTHUE,RED_, _WREDRAW,ON_);

 sWo(_WOID,picwo,_WPIXMAP,ON_,_WDRAW,ON_,_WSAVE,ON_,_WSAVEPIXMAP,ON_,_WREDRAW,ON_)

    _WPOS = woGetPosition(picwo);

<<"%V $_WPOS\n";
   //ans=query("?","_WPOS done assign ",__LINE__);

   int ncols = 1000;
   int nrows = _WPOS[6] -2;
 
   nxpix=   _WPOS[5] -2;

   npics = dcols/ nxpix;
   npics++;
   ncols = dcols / npics

   ncols /= 2;
   ncols *= 2;

   nrows /= 2;
   nrows *= 2;


<<"%V $nxpix $drows $nrows $dcols $npics $(ncols * npics)\n"


 if (!use_cpix) {
   PH[1] = ncols * npics;
   PH[2] = drows;
   PH[0] = drows * PH[1];
   wdata(CF,PH);
 }

// how many rows can we display ?

// how many cols (pixels)  ?
   uint  nbw;
   uchar Tile[2000];



   sWo(_WOID,picwo,_WCLIP,wbox(4,4,nrows,ncols,2));


   titleButtonsQRD(vp);

   titleVers();


  sWo(_WOID,picwo,_WSCALES,rbox(wlng,slat,elng,nlat));

// igc_tgl = cGl(picwo,_TXY,IGCLONG,IGCLAT,_color,BLUE_,_flush);

  int igc_tgl = cGl(picwo);

  sGl(igc_tgl,_GLXVEC,IGCLONG,_GLYVEC,IGCLAT,_GLHUE,BLUE_);



    //igc_vgl = cGl(vvwo,_TY,IGCELE,_color,RED_);

   sWi(_WOID,vp,_WREDRAW,ON_);

//color map index - 16 start of default 64 grey scale

<<"plotline \n"

   plot(picwo,_line,wlng,slat,elng,nlat,RED_)

<<"plotline2 \n"

   plot(picwo,_line,wlng,nlat,elng,slat,BLUE_)
   

   dGl(igc_tgl);



   sWo(_WOID,picwo,_WSHOWPIXMAP,ON_);

 //query()

 // AF= ofr("chey97.dat")

  // sec_col =  1620; // 109
    // sec_row = 460; // 40   - dec degrees
    
//   AF= ofr("den103.dat")

  // sec_row = 640; // 35.5   - dec degrees
  // sec_col =  5700; // 109

    sec_row = 633;
    sec_col = 1500;

   skip_col = 3;
   skip_row = 3;
   scols = (ncols * (skip_col+1))
   srows = (nrows * (skip_row+1))   
<<"%V $npix $drows $dcols \n"

   sWo(_WOID,picwo,_WCLIP,wbox(0,0,ncols,nrows,2));

<<"clip is: $_WPOS\n"

   // one deg lat  is apprx 2620 rows
   
   //float dlat = srows / 2620.0; // chey
   float dlat = srows / 2840.0; // den
   
   // one deg long -- depends on lat
   // use ave of lats/latn  - lng measures
   
   //float dlng = scols /2000.0; // chey
   float dlng = scols /2100.0; // den

   plat = 2100;
   plng = 2100;
   
   //slat = 35.61

   slat = 35.58;  // den lhc
  // slat = 36.0  // den lhc
   //slat = 40.0  //chy lhc
   nlat = slat + dlat;
   //wlng = 109.0
   wlng = 111.0;
   wedge = 111.0;
   sedge = 35.58;
   
   elng = wlng - dlng;   
   do_sec =1;

   replot = 1;

   /////////////////////////////////////  MAIN LOOP //////////////////////////
  //sdb(1,_~pline,_~trace);
  np = 1000;


 while (1) {
   



   scols = ncols * (skip_col+1);
   srows = nrows * (skip_row+1);

   dlng = scols / 2100.0; // den - depends on lat - needs lat adjustment
   dlat = srows / 2840.0; // den

   sWo(_WOID,picwo,_WRHTSCALES,rbox(sec_col,sec_row,sec_col+scols,sec_row+srows));
   
   sWo(_WOID,picwo,_WLHBSCALES,rbox(wlng,slat,elng,nlat));   

   if (replot) {

       sWo(_WOID,picwo,_WCLEARPIXMAP,ON_);
       
   //sWo(picwo,_scales,sec_col,sec_row,sec_col+scols,sec_row+srows);

       fseek(AF,12,0);

// over eastern edge   
   if ((sec_col + scols) > dcols) {
        sec_col = dcols - scols -2;
        sWo(_WOID,picwo,_WRHTSCALES,rbox(sec_col,sec_row,sec_col+scols,sec_row+srows));
	// ? elng  -- depends on lat -  need this per deg lat
	elng = wedge + dcols/2100.0; // den
	wlng = sec_col/2100.0; // den
	//
   }
// over northern edge   
   if ((sec_row + srows) > drows) {

        sec_row = drows - srows -2;
	sWo(_WOID,picwo,_WRHTSCALES,rbox(sec_col,sec_row,sec_col+scols,sec_row+srows));
	nlat = sedge + (sec_row+srows)/ 2840.0;
        slat = nlat - (srows/ 2840.0);

   }
   
   sWo(_WOID,picwo,_WCLEARPIXMAP,ON_);

   if (do_sec) {
   
   if (use_cpix) {
     //CPIX = 0;
     cval = 32;
     
     npixr = mread(AF,CPIX,nrows,ncols,drows,dcols,sec_row,sec_col,skip_row,skip_col);
     
     <<"CPIX read $npixr  ? 0 error ? \n";


    CPIX.pinfo();
 sz=Caz(CPIX);
 <<"$sz \n";

    


int naz= 0;
    int kc = 0;
/*    
   for (i=0; i< 500; i++) {
      for (j = 0; j < 100 ; j++) {
      cval = CPIX[i][j];
      if (cval > 0) {
      naz++;
        }
<<"$i $j $naz $cval \n"
     }
    }

<<"%V $naz\n"
*/

 np2 = np +50;
<<"%V $sz $npixr $np $np2 $CPIX[np] \n"
<<"$CPIX[np:np2] \n"

 np = np2;
    <<"$(Cab(CPIX))\n"
   }
   else {
     npixr = mread(AF,SPIX,nrows,ncols,drows,dcols,sec_row,sec_col,skip_row,skip_col);
     <<"read SPIX $npixr\n";

   } 

<<"%V $nrows $ncols $drows $dcols $npixr $sec_row $sec_col   \n"


 if ( use_cpix) {
<<"read $npixr\n"
//   Redimn(CPIX,nrows,ncols)
   CPIX.pinfo();

   RPIX = mrevRows(CPIX);   // this corrupts fix 03/11/22
  
   RPIX.pinfo();


    for (j=0;j < 2; j++) {
<<"<|$j|> $CPIX[j][0:1000:50]\n"    
<<"<|$j|> $RPIX[j][0:1500:50]\n"
  }

//<<"$(Cab(RPIX))\n"
<<"plotting pixrect  $cmi\n"

    //PlotPixRect(picwo,RPIX,cmi);
    
    PlotPixRect(picwo,CPIX,cmi);

  }

   else {

   Redimn(SPIX,nrows,ncols)
   nec= vtrans(SPIX,CM)
   vcmpset(SPIX,">",256,0)
   //TPIX = mrevRows(SPIX)
   TPIX = SPIX

   Tile = TPIX;
   //PlotPixRect(picwo,TPIX,cmi)
   PlotPixRect(picwo,Tile,cmi);

   //wdata(BF,TPIX)
  // Tile = 234;
  //    Tile[1] = 123;
   nbw += wdata(CF,Tile)
       for (j=0;j < 10; j++) {
<<"$j $TPIX[j][0:200:]\n"       
<<"$j $Tile[j][0:200:10]\n"
   }
// Redimn(Tile)
 <<"$(Cab(TPIX)) $(Typeof(TPIX))  \n"
 <<"$(Cab(Tile)) $(Typeof(Tile)) $nbw \n"


  }
 }



   sWo(_WOID,picwo,_WSHOWPIXMAP,ON_)

   sWo(_WOID,picwo,_WDRAW,ON_)

//   plot(picwo,_line,wlng,slat,elng,nlat,RED_)

//   plot(picwo,_line,wlng,nlat,elng,slat,BLUE_)


     dGl(igc_tgl);  // plot the igc track -- if supplied

  
    sWo(_WOID,picwo,_WSHOWPIXMAP,ON_);
  }

<<"%V $wlng $slat $elng $nlat \n"
<<"where are we? %V $sec_col $sec_row \n"

    
    // while (1)
    

      eventWait();

<<"click the mouse $Ev_loop\n";
print("click the mouse %d\n",Ev_loop);



       targ_col = Ev_x;
       targ_row = Ev_y;
       
//       tlng = Ev_ry;
//       tlat = Ev_rx;


<<"%V $Ev_button  $Ev_x  $Ev_y\n"

    


/*
      ans=query("where are we?")
// ip lat,lng in dec-deg  - center map ??
*/

   //  titleMessage("$targ_col $targ_row %V $tlat $tlng")
    
    // sWo(picwo,_drawoff)




   if (sec_row >= drows) {
<<"%V $sec_row $drows \n"
    break;

   }
<<"%V$Ev_button $Ev_keyc\n"
      replot = 1;
      if ( Ev_keyc == 'S') {
         goEast()
     }
     else if ( Ev_keyc == 'Q') {
         goWest()
     }
     else if (Ev_button == 4 || Ev_keyc == 'R') {
         goNorth()
     }
     else if (Ev_button == 5 || Ev_keyc == 'T') {
         goSouth()
     }
     else if ( Ev_keyc == 'X') {

                skip_row++
	if (skip_row >=4) {
	   skip_row =4
	   }
        skip_col++
	if (skip_col >=4) {
	   skip_col =4
	   }
	   
<<"Zoom out $skip_row $skip_col \n"

     }
     else if ( Ev_keyc == 'x') {
                skip_row--
	if (skip_row < 0) {
	   skip_row =0
	   }
        skip_col--
	if (skip_col <0) {
	   skip_col =0
	   }
	   
     <<"Zoom in $skip_row $skip_col \n"
     
     }               
     else if (Ev_button == 2) {
     <<"center on click position \n"
         	    <<"%V $targ_col $targ_row  $sec_col $sec_row  $ncols $nrows\n"
            mid_col = sec_col + scols/2;
	    mid_row = sec_row + srows/2;
	    adj_col = mid_col - targ_col;
	    adj_row = mid_row - targ_row;
	    sec_col -= adj_col;
	    sec_row -= adj_row;
	    <<"%V $mid_col $mid_row $adj_col $adj_row $sec_col $sec_row\n"
	    if (sec_col < 0 ) sec_col = 0;
	    if (sec_row < 0) sec_row = 0;

  	 <<"%V $targ_col $targ_row $sec_col $sec_row $skip_col $skip_row $srows $scols\n"
	 
     }
     else {
             replot = 1;

     }
     	     <<"%V$replot \n";
 }



<<"out of section map\n"


///////////////////////////////    DEV //////////////////////////////////////////////////
/*


   [1]  prevent going over north / east edge    [ ]

   [2] plot some TP's from bbrief.cup              [ ]

   [3] Use larger pixmap and scroll                  [ ]

   [4]  join up surrouding sectionals -- chey+den    [ ]

   [5]  show lat,lng decimal degree of click   (in the title message bar)   [ ]

   [6]  nearest landing place(s) in 35/1 glide at  4000 AGL


*/
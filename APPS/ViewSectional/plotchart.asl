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


//////////////////////////////////////////////////////////////////////////////////////
//
//
//
//
//
//
//
//
///////////////////////////////////////////////////////////////////////////////////////


Str Use_= " Demo  of show igc track on sectional ";

#define _ASL_ 1



#include "debug.asl"

  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
  } 

   allowErrors(-1); 

  chkIn(_dblevel)




#include "chart_procs.asl"



fname = _clarg[1];

int cval;

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

float dy = 0.2;
float dx = 0.2;



float x0,y0,x1,y1;



  Vec<float> IGCLONG(7000);

  Vec<float> IGCLAT(7000);

  Vec<float> IGCELE(7000);

  Vec<float> IGCTIM(7000);



  //sdb(1,_~pline,_~trace);

     do_pix_stuff = 1;
      use_cpix = 1;
//   using a coded version of cmap indices (char) instead of rgb u32 values
    do_trans = 0;
    int naz= 0;
    int kc = 0;
    
  sec_row =   0;
  sec_col =  0;

Str igcfn = "spk.igc";

<<"%V $igcfn \n"

// igcfn = getArgStr();

   slat = 35.0;
   nlat = 42.0;
   wlng = 110.0;
   elng =  104.0 ;

   x0 = wlng;
   y0 = slat;




    igcfn.pinfo();


    Ntpts= IGC_Read(igcfn);



  int  midpt = Ntpts /2;

<<" read igc $Ntpts $midpt\n"

   if (Ntpts == 0) {
<<"Bad read exit\n"
     exit(-1)
   }



//<<" $IGCLONG[0:20] \n"

//<<" $IGCLAT[0:20] \n"

//<<" $IGCTIM[0:20] \n"

<<" SEE THIS?\n"


#include "hv.asl"
#include "tbqrd.asl"


  m20 =(midpt+20);

//<<" $IGCLAT[midpt:(midpt+20):] \n"

//<<" $IGCLAT[midpt:m20:] \n"
//<<" $IGCLONG[midpt:m20] \n"

   cmp_name = "${fname}.cmp";

  if (use_cpix) {
      
     AF= ofr(cmp_name) ; // den103.cmp")
   }
 else {

    AF= ofr("${fname}.dat") ;   // den103.dat rgb u32 values
    CF= ofw("new.cmp") ;   // output the cmap index file  1/4 byte size of original
  }

  if (AF == -1) {
   <<"error open $cmp_name\n";
    exit(-1);
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

uchar CPIX[];  // make dynamic ? - cpp

// openDll("image");

 uint SPIX[0];



 map_name = "cmap_${fname}";

<<"$fname $map_name \n"


 A= ofr(map_name);

  Mat CM(UINT_,200,10)
  
  CM.readRecord(A,_RTYPE,UINT_);

 sz= Caz(CM);
 cmb = Cab(CM)
 


 CM.pinfo()
 
 nc = cmb[0] ;

 <<"%V $sz $cmb $nc\n"


<<"CM $CM[1:10][::] \n"

#include "graphic"


   rainbow();
  // CMAP

 ngl = 256;
 //cmi = 64  ; // above our basic colors

cmi = 16  ; // above our basic colors

<<"%V $ngl $cmi \n"


//cmi = 6;

 int cindex = cmi;


  setGSmap(ngl,cmi);



//   chartCmap(CM, nc , cmi) ;
  chartCmap(nc , cmi) ; // need to be in graphic coms section
!a
/// import cmap for chart
/// setup cmap

///  get raster file of chart color pixel
///  pull out row/col ( 512 x 512) section  

/// plot section

// want this to contain a 512X512 image -- so that plus borders and title
  

//sdb(0);

/// SCRN SETUP
#include "gevent.asl"



  



int wpos[10]

     vp =  cWi("PIC_WINDOW");

     sWi(_WOID,vp,_WRESIZE,wbox(0.01,0.01,0.9,0.95,0),_WREDRAW,ON_);


// again must be greater the 512x512 plus the borders
 
// picwo=cWo(vp,_GRAPH,_name,"Pic",_color,PINK_,_resize,40,20,1840,820,1,_flush)

   picwo=cWo(vp,WO_GRAPH_);
   
   sWo(_WOID,picwo,_WNAME,"PIC",_WCOLOR,PINK_,_WRESIZE,wbox(40,20,1840,820,1));

// set the clip to be 512x512 --- clipborder has to be on pixel outside of this!

   sWo(_WOID,picwo,_WBORDER,BLACK_,_WDRAW,ON_,_WFONTHUE,RED_, _WREDRAW,ON_);

 //sWo(_WOID,picwo,_WPIXMAP,ON_,_WDRAW,ON_,_WSAVE,ON_,_WSAVEPIXMAP,ON_,_WREDRAW,ON_)
   sWo(_WOID,picwo,_WPIXMAP,ON_,_WSAVE,ON_,_WSAVEPIXMAP,ON_,_WREDRAW,ON_)


    wwo=woGetPosition(picwo, wpos);

<<"%V $wwo $wpos\n";


   int ncols = 1000;
   int nrows = wpos[6] -2;
 
   nxpix=   wpos[5] -2;

   npics = dcols/ nxpix;
   npics++;
   ncols = dcols / npics;

   if (nxpix > 1200) {
       ncols = 1200;
   }

   ncols /= 2;
   ncols *= 2;

   nrows /= 2;
   nrows *= 2;
   // assumes clip dx  is 1000 !

  <<"%V $nxpix $npics $drows $nrows $ncols $dcols $npics $(ncols * npics)\n"


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



   sWo(_WOID,picwo,_WCLIP,wbox(10,10,ncols+10,nrows+10,2));


   titleButtonsQRD(vp);

   titleVers();




  sWo(_WOID,picwo,_WSCALES,rbox(wlng,slat,elng,nlat));

// igc_tgl = cGl(picwo,_TXY,IGCLONG,IGCLAT,_color,BLUE_,_flush);

  int igc_tgl = cGl(picwo);

  sGl(igc_tgl,_GLXVEC,IGCLONG,_GLYVEC,IGCLAT,_GLHUE,YELLOW_,_GLWIDTH,2);



    //igc_vgl = cGl(vvwo,_TY,IGCELE,_color,RED_);

   sWi(_WOID,vp,_WREDRAW,ON_);

//color map index - 16 start of default 64 grey scale

<<"plotline \n"

   plot(picwo,_line,wlng,slat,elng,nlat,RED_)

<<"plotline2 \n"

   plot(picwo,_line,wlng,nlat,elng,slat,BLUE_)

   plotLine(picwo,wlng,slat+0.2,elng,nlat-0.2,RED_)

   titleMessage(vp,"%V $wlng $slat $elng $nlat");

   sGl(_GLID,igc_tgl,_GLDRAW,YELLOW_);  // DrawGline;

 //  sWo(_WOID,picwo,_WSHOWPIXMAP,ON_);

//   dGl(igc_tgl);
 //query()

 // AF= ofr("chey97.dat")

  // sec_col =  1620; // 109
    // sec_row = 460; // 40   - dec degrees
    
//   AF= ofr("den103.dat")

  // sec_row = 640; // 35.5   - dec degrees
  // sec_col =  5700; // 109

   // where to start  lat,lng - center ?


    sec_row = 633;
    sec_row_min = 633;
    sec_col = 1500;
    sec_col_min = 1500;

  // what is skip going to do to the image ?
   skip_col = 2;  // was 3
   skip_row = 2;

   scols = (ncols * (skip_col+1))
   srows = (nrows * (skip_row+1))   
<<"%V $npix $drows $dcols $scols  $srows\n"

   sWo(_WOID,picwo,_WCLIP,wbox(10,10,ncols+10,nrows+10,2));

<<"clip is: $wpos\n"

   // one deg lat  is apprx 2620 rows
   
   //float dlat = srows / 2620.0; // chey
   float dlat = srows / 2840.0; // den
   
   // one deg long -- depends on lat
   // use ave of lats/latn  - lng measures
   
   //float dlng = scols /2000.0; // chey
   float dlng = scols /2100.0; // den

   plat = 2100;
   plng = 2100;


///   chey or den ?

   
   //slat = 35.61
   slat_min = 35.58;  // den lhc
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

 int m_init = 1;
 <<" @ loop \n"
 while (1) {
 
  if (m_init) {
      m_init = 0;
  }
  else {
  
    eventWait();
  <<"click the mouse %V $GEV_loop $GEV_button $GEV_rx $GEV_ry %c $GEV_keyc\n";
  // print("click the mouse %d %d\n",GEV_loop, GEV_keyc);

    replot =1;
    if ( GEV_keyc == 'S') {
         goEast()
     }
     else if ( GEV_keyc == 'Q') {
         goWest()
     }
     else if (GEV_button == 4 || GEV_keyc == 'R') {
         goNorth()
     }
     else if (GEV_button == 5 || GEV_keyc == 'T') {
         goSouth()
     }
     else if ( GEV_keyc == 't') {
         Top();
     }
     else if ( GEV_keyc == 'e') {
         East();
     }
     else if ( GEV_keyc == 'w') {
         West();
     }          
     else if ( GEV_keyc == 'b') {
         Bottom();
     }          
     else if ( GEV_keyc == 'x') {
         zoomOut();
     }
     else if ( GEV_keyc == 'z') {
           zoomIn();
    }               
     else if (GEV_button == 2) {
            centerPos();
     }
     else {
       replot = 0;
     }
<<"%V $replot \n";
  }


   scols = ncols * (skip_col+1);
   srows = nrows * (skip_row+1);

   dlng = scols / 2100.0; // den - depends on lat - needs lat adjustment
   dlat = srows / 2840.0; // den

  // sWo(_WOID,picwo,_WRHTSCALES,rbox(sec_col,sec_row,sec_col+scols,sec_row+srows));
   
   sWo(_WOID,picwo,_WLHBSCALES,rbox(wlng,slat,elng,nlat));   

   if (replot) {

       sWo(_WOID,picwo,_WCLEARPIXMAP,ON_);
       
   //sWo(picwo,_scales,sec_col,sec_row,sec_col+scols,sec_row+srows);

       fseek(AF,12,0);

/*
// over eastern edge   
   if ((sec_col + scols) > dcols) {
        sec_col = dcols - scols -2;
      //  sWo(_WOID,picwo,_WRHTSCALES,rbox(sec_col,sec_row,sec_col+scols,sec_row+srows));
	// ? elng  -- depends on lat -  need this per deg lat
	elng = wedge + dcols/2100.0; // den
	wlng = sec_col/2100.0; // den
	//
   }
// over northern edge   
   if ((sec_row + srows) > drows) {

        sec_row = drows - srows -2;
//	sWo(_WOID,picwo,_WRHTSCALES,rbox(sec_col,sec_row,sec_col+scols,sec_row+srows));
	nlat = sedge + (sec_row+srows)/ 2840.0;
        slat = nlat - (srows/ 2840.0);

   }
*/

   sWo(_WOID,picwo,_WCLEARPIXMAP,ON_);
   
   if (use_cpix) {

     cval = 32;
     
     npixr = matread(AF,CPIX,nrows,ncols,drows,dcols,sec_row,sec_col,skip_row,skip_col);
     


<<" %d $CPIX[1:10][1:5:] \n"
/*
 for (i = 0; i < 50 ; i++) {
   for(j= 0; j < 100; j++) {
     
     val = CPIX[i][j]
     if (val <200) { 
     <<"$val "
     }
    }
     <<"\n" 
}
*/
  //   CPIX.pinfo();

<<"%V $npixr $nrows $ncols $drows $dcols $npixr $sec_row $sec_col  $skip_row $skip_col $srows $scols\n"

<<"plotting pixrect  $cmi\n"

//  sWo(_WOID,picwo,_WCLEARCLIP,ORANGE_);

      PlotPixRect(picwo,CPIX,cmi);

    }
 
  }




// plot box?
   //plot(picwo,_line,wlng,slat,elng,nlat,RED_)
   
       targ_col = GEV_x;
       targ_row = GEV_y;
       
       tlat = GEV_ry;
       tlng = GEV_rx;
    

<<"%V $wlng $slat $elng $nlat \n"
<<"where are we? %V $sec_col $sec_row \n"


<<"%V  POS $tlng  $tlat $GEV_x $GEV_y \n")




   if (sec_row >= drows) {
<<"%V $sec_row $drows \n"
    break;

   }
   <<"%V$GEV_button $GEV_keyc\n"

//  wlng = 107;
//  elng = 103;
//  slat = 36;
//  nlat = 39;

  if (replot) {
   titleMessage(vp,"%V $wlng $slat $elng $nlat");
    sWo(_WOID,picwo,_WDRAW,ON_,_WSCALES,rbox( wlng, slat, elng, nlat)); // updated scales

    sGl(_GLID,igc_tgl,_GLDRAW, RED_);  // DrawGline;   // this has to retrieve updated scales
    sWo(_WOID,picwo,_WCLIPBORDER, BLACK_,_WSHOWPIXMAP,ON_)  ;
  }
  else {
    titleMessage("$targ_col $targ_row  $tlat $tlng ");
  }
//  sWo(_WOID,picwo,_WCLEARPIXMAP,ON_)

  

   //wlng.pinfo();
   //elng.pinfo();
   //slat.pinfo();
   //nlat.pinfo();
   //
  // x0 += dx;
  // y0  += dy;


  




}



//<<"out of section map\n"


///////////////////////////////    DEV //////////////////////////////////////////////////
/*
   // skip row/col  - crude zoom out of raster image

   [1]  prevent going over north / east edge    [ ]

   [2] plot some TP's from bbrief.cup              [ ]

   [3] Use larger pixmap and scroll                  [ ]

   [4]  join up surrouding sectionals -- chey+den    [ ]

   [5]  show lat,lng decimal degree of click   (in the title message bar)   [ ]

   [6]  nearest landing place(s) in 35/1 glide at  4000 AGL


*/

////////////////////////////////////////////////////////////////////////////////

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

#if 0
   else if (do_trans) {

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
   nbw += wdata(CF,Tile);
/*  
       for (j=0;j < 10; j++) {
<<"$j $TPIX[j][0:200:]\n"       
<<"$j $Tile[j][0:200:10]\n"
   }
*/

// Redimn(Tile)
// <<"$(Cab(TPIX)) $(Typeof(TPIX))  \n"
// <<"$(Cab(Tile)) $(Typeof(Tile)) $nbw \n"
  }

   else {
     npixr = matread(AF,SPIX,nrows,ncols,drows,dcols,sec_row,sec_col,skip_row,skip_col);
     <<"read SPIX $npixr\n";
   } 


#endif



#if 0

    np2 = np +50;
  <<"%V $sz $npixr $np $np2 $CPIX[np] \n"
//<<"$CPIX[np:np2] \n"
   np = np2;


//   Redimn(CPIX,nrows,ncols)
   //CPIX.pinfo();

   //RPIX = mrevRows(CPIX);   // this corrupts fix 03/11/22
  
   //RPIX.pinfo();

/*
    for (j=0;j < 2; j++) {
<<"<|$j|> $CPIX[j][0:1000:50]\n"    
<<"<|$j|> $RPIX[j][0:1500:50]\n"
  }
*/
//<<"$(Cab(RPIX))\n"

#endif

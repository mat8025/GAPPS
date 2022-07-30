//%*********************************************** 
//*  @script plot-tile.asl 
//* 
//*  @comment demo rgb average of sectional digital map 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.77 C-He-Ir]                               
//*  @date Sat Oct 17 17:11:02 2020 
//*  @cdate 10/01/2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();
///
///
///

#include "debug"
#include "hv"

  scriptDBOFF();

setmaxcodeerrors(-1); // just keep going
setmaxicerrors(-1);


AF=ofr(_clarg[1]);  // color map file ?

r= atoi(_clarg[2])
c= atoi(_clarg[3])

showall =1;
uint PH[3]

nir=vread(AF,PH,3,UINT_)
int npix = PH[0]

<<"$PH\n"
//uint MI[>10]

// should size MI to required

cstart = c

uint val = hex2dec("ffffffff")
wd = PH[1]
 ht = PH[2]
uint MI[PH[0]]
<<"%V $wd $ht \n"

nir=vread(AF,MI,wd*ht,UINT_)
cf(AF)


npc = 3000
npr = 3000;
ovl = 3000
nr = npr;
nc = npc;

redimn(MI,ht,wd)

TIL = mtile(MI,r,c,nr,nc,1)
<<"extract $nr x $nc tile at $r $c\n"


PH[0] = nr * nc;
PH[1] = nc;
PH[2] = nr;

B=ofw("tile1.dat")
wdata(B,PH)
wdata(B,TIL)
cf(B)


c += ovl
TIL = mtile(MI,r,c,nr,nc,1)
<<"extract $nr x $nc tile at $r $c\n"



B=ofw("tile2.dat")
wdata(B,PH)
wdata(B,TIL)
cf(B)

c += ovl 
TIL = mtile(MI,r,c,nr,nc,1)
<<"extract $nr x $nc tile at $r $c\n"

B=ofw("tile3.dat")
wdata(B,PH)
wdata(B,TIL)
cf(B)


uchar CPIX[>2000];
uint SPIX[];
uint SPIX2[];
uint SPIX3[];

uchar CMSPIX[];

// dat XRGB or cmp cindex

use_cpix =0;  // cmp 
 sec_row =   0;
 sec_col =  0;
 if (use_cpix) {
    AF= ofr("tile1.cmp")
}
else {
     AF= ofr("tile1.dat")
     AF2= ofr("tile2.dat")
     AF3= ofr("tile3.dat")          
     
     <<"using 32 xRGB words\n"
}

nir=vread(AF,PH,3,UINT_)

npix = PH[0]
drows = PH[2]
dcols = PH[1]

nir=vread(AF2,PH,3,UINT_)
nir=vread(AF3,PH,3,UINT_)


// default size 512x512

/// setup of color map


///   dat file
///   tile is n*m  of uint's -  each uint a XRGB  color pixel
///   option reduce 5x5 averager
//   convert input tile into matrix of cmap indices

//  cmp file
//  tile is already coded as cmap indices



 A= ofr("cmapi-den")
 
 CM= readRecord(A,@type,UINT_)

 cmb = Cab(CM)
 <<"$cmb\n"
 
 nc = cmb[0] 

 // <<" $CM[::][::] \n"


#include "graphic"
#include "gevent"
include "tbqrd"

fullpic = 0;
reduce = 1;

// CMAP

ngl = 256

cmi = 64
cindex = cmi

for (i=0; i< nc; i++) {
   hexw= CM[i][1]
//<<"$i $cindex $hexw \n"
   setRGB(cindex,hexw,0)
    cindex++
}


// plot


// want this to contain a 512X512 image -- so that plus borders and title
  
  vp =  cWi(_title,"PIC_WINDOW",_resize,0.01,0.01,0.9,0.95,0,_eo)

 //vp =  cWi(_title,"PIC_WINDOW",_pixresize,50,50,1850,950,0)


// again must be greater the 512x512 plus the borders
 
 picwo=cWo(vp,_GRAPH,_name,"Pic",_color,PINK_,_resize,2,20,502,820,1,_eo)

// set the clip to be 512x512 --- clipborder has to be on pixel outside of this!

 sWo(picwo,_border,_drawon,_clipborder,_fonthue,RED_, _redraw)

 sWo(picwo,_pixmapon,_drawoff,_save,_savepixmap,_redraw)

 pic2wo=cWo(vp,_GRAPH,_name,"RPic",_color,LILAC_,_resize,502,20,1002,820,1,_eo)

// set the clip to be 512x512 --- clipborder has to be on pixel outside of this!

 sWo(pic2wo,_border,_drawon,_clipborder,_fonthue,RED_, _redraw)

 sWo(pic2wo,_pixmapon,_drawoff,_save,_savepixmap,_redraw)

 pic3wo=cWo(vp,_GRAPH,_name,"Pic3",_color,TEAL_,_resize,1002,20,1502,820,1,_flush)

// set the clip to be 512x512 --- clipborder has to be on pixel outside of this!

 sWo(pic3wo,_border,_drawon,_clipborder,_fonthue,RED_, _redraw)

 sWo(pic3wo,_pixmapon,_drawoff,_save,_savepixmap,_redraw)
 

   int ncols = npc;
   int nrows = npr;
 
   uint  nbw;
   uchar Tile[]


   sWo(picwo,_clip,0,0,500,600,2,_eo)
   sWo(pic2wo,_clip,0,0,500,600,2,_eo)
   sWo(pic3wo,_clip,0,0,500,600,2,_eo)

  IC=WoGetClip(picwo)
<<"%V$IC\n"
  IC2=WoGetClip(pic2wo)
<<"%V$IC2\n"

   titleButtonsQRD(vp)
   titleVers();
   titleMsg("Sectional Tiles")

   sWi(vp,_redraw)
   

   sWo(picwo,_clearpixmap)
   sWo(pic2wo,_clearpixmap)
   sWo(pic3wo,_clearpixmap)

   skip_row = 0;
   skip_col =0;

   if (use_cpix) {
     CPIX = 0;
     npixr = mread(AF,CPIX,nrows,ncols,drows,dcols,sec_row,sec_col,skip_row,skip_col)
 //   <<"$CPIX[1][0:200:10]\n"
//    <<"$(Cab(CPIX))\n"
   }
   else {
     npixr = mread(AF,SPIX,nrows,ncols,drows,dcols,sec_row,sec_col,skip_row,skip_col)
     <<"%V $npixr  $nrows $ncols   $(nrows*ncols)\n"
     npixr2 = mread(AF2,SPIX2,nrows,ncols,drows,dcols,sec_row,sec_col,skip_row,skip_col)
     npixr3 = mread(AF3,SPIX3,nrows,ncols,drows,dcols,sec_row,sec_col,skip_row,skip_col)     
     <<"%V $npixr  $npixr2 $nrows $ncols   $(nrows*ncols)\n"
} 


 if ( use_cpix) {
<<"read $npixr\n"
//   Redimn(CPIX,nrows,ncols)
   
   RPIX = mrevRows(CPIX)
  
   PlotPixRect(picwo,RPIX,cmi)

}
else {
   sz= Caz(SPIX)
   //<<"$SPIX[0][0:10]\n"


   Redimn(SPIX,nrows,ncols)
   rsz= Caz(SPIX)
   <<"%V $sz $rsz \n"
   RSPIX = SPIX

   Redimn(SPIX2,nrows,ncols)
   RSPIX2 = SPIX2

   Redimn(SPIX3,nrows,ncols)
   RSPIX3 = SPIX3

  if (fullpic) {
   nec= vtrans(SPIX,CM)
   vcmpset(SPIX,">",256,0)
   TPIX = mrevRows(SPIX)
   Tile = TPIX;


   sWo(picwo,_savepixmap,10,10,700,900)
   PlotPixRect(picwo,Tile,cmi)
   sWo(picwo,_showpixmap)
  }

   if (reduce) {
   AVESPIX = imrgbave(RSPIX,5)


   <<"AVESPIX $(Cab(SPIX)) $(Cab(AVESPIX)) $(typeof(AVESPIX)) \n"
   // want fin to pick closest cmap to the rgb word
 //  nec= vtrans(AVESPIX,CM); // this matches rgb to map - if rgb is in CM table
    CMSPIX=rgbToColorIndex(AVESPIX,cmi,cmi+nc)
   //vcmpset(AVESPIX,">",256,0)
   nb= Cab(AVESPIX)
   <<"%V$nb\n"
   redimn(CMSPIX,nb[0],nb[1])
//   <<"$CMSPIX[0][0:10] \n"
//   <<"$CMSPIX[2][0:10] \n"
   //<<"$CMSPIX[125][0:10] \n"
   RPIX = mrevRows(CMSPIX)
//   <<"$RPIX[2][0:10] \n"
   R5Tile = RPIX;
//<<"$R5Tile[2][0:10] \n"   
   <<" $(Cab(RPIX)) $(Cab(R5Tile)) $(typeof(R5Tile))\n"
   R5D= cab(R5Tile)
    sWo(picwo,_savepixmap,0,0,1000,1000,_eo)
   T=fineTime()
   PlotPixRect(picwo,R5Tile,0)
   dt=fineTimeSince(T,1)
   <<" took $(dt/1000000.0) secs\n"
    sWo(picwo,_showpixmap)
int TH[6]
TH[0] = r
TH[1] = cstart;
TH[2] = r + npr
TH[3] = cstart + npc
TH[4] = R5D[0]
TH[5] = R5D[1]

B=ofw("tile1.cmp")
wdata(B,TH)
wdata(B,R5Tile)
cf(B)



   if (showall) {
   AVESPIX = imrgbave(RSPIX2,5)
   <<" $(Cab(SPIX)) $(Cab(AVESPIX)) $(typeof(AVESPIX)) \n"

   CMSPIX=rgbToColorIndex(AVESPIX,cmi,cmi+nc)
   nb= Cab(AVESPIX)
   redimn(CMSPIX,nb[0],nb[1])
   RPIX = mrevRows(CMSPIX)
   R5Tile = RPIX;
      sWo(pic2wo,_savepixmap,1000,0,2000,810,_eo)
    PlotPixRect(pic2wo,R5Tile,0)

B=ofw("tile2.cmp")
TH[1] += npc
TH[3] += npc
wdata(B,TH)
wdata(B,R5Tile)
cf(B)


sWo(pic2wo,_showpixmap)
   T=fineTime()
   PlotPixRect(picwo,R5Tile,0,1000,0)
   dt=fineTimeSince(T,1)
   <<" took $(dt/1000000.0) secs\n"
   AVESPIX = imrgbave(RSPIX3,5)
   <<" $(Cab(SPIX)) $(Cab(AVESPIX)) $(typeof(AVESPIX)) \n"
   dt=fineTimeSince(T,1)
   <<" took $(dt/1000000.0) secs\n"
   CMSPIX=rgbToColorIndex(AVESPIX,cmi,cmi+nc)
   nb= Cab(AVESPIX)
   redimn(CMSPIX,nb[0],nb[1])
   RPIX = mrevRows(CMSPIX)
   R5Tile = RPIX;




    sWo(pic3wo,_savepixmap,1000,0,2000,810,_eo)
 // sWo(pic3wo,_savepixmap)
    PlotPixRect(pic3wo,R5Tile,0)
 //   sWo(pic3wo,_showpixmap,_savepixmap,_save)
    sWo(pic3wo,_showpixmap)
  //    PlotPixRect(pic2wo,R5Tile,0,1000,0)
    //  PlotPixRect(picwo,R5Tile,0,2000,0)
B=ofw("tile3.cmp")
TH[1] += npc
TH[3] += npc
wdata(B,TH)
wdata(B,R5Tile)
cf(B)

    }
  }
}




   sWo(pic3wo,_clearclip,_clip,0,10,600,550,2,_eo);
   sWo(pic2wo,_clearclip,_clip,0,10,600,550,2,_eo);

      sWo(pic2wo,_showpixmap);
      sWo(pic3wo,_showpixmap);


    updown = 200;
    rl = 200;
  while (1) {


     eventWait();
     ME=getMouseState()
//<<"%6.2f $ME[7] $ME[8] $ME[9] $ME[10]\n"
//<<"%V$_ebutton\n"
     if (_ebutton == RIGHT_) {
     updown += 10
     rl += 10
     sWo(picwo,_scrollclip,RIGHT_,rl,_eo)
     sWo(pic2wo,_scrollclip,RIGHT_,updown,_eo)
     sWo(pic3wo,_scrollclip,RIGHT_,updown,_eo)

     }
     if (_ebutton == LEFT_) {
     updown -= 10;
     rl -= 10;
     sWo(picwo,_scrollclip,RIGHT_,rl)
     sWo(pic2wo,_scrollclip,RIGHT_,updown)
     sWo(pic3wo,_scrollclip,RIGHT_,updown)

     }

     if (_ebutton == UP_) {
     updown += 10;
     rl += 10;
     sWo(picwo,_scrollclip,UP_,rl)
     sWo(pic2wo,_scrollclip,UP_,updown)
     sWo(pic3wo,_scrollclip,UP_,updown)
     }

     if (_ebutton == DOWN_) {
     updown -= 10;
     rl -= 10;
     sWo(picwo,_scrollclip,UP_,rl)
     sWo(pic2wo,_scrollclip,UP_,updown)
     sWo(pic3wo,_scrollclip,UP_,updown)
     }     


  }




/////////////////////////////////// DEV /////////////////////////////
/*  

   6 tiles   - > window pixmap

   view area  less than  map
   slide around the view area


   3x3  and 5x5   size's


   lat,long  translation - scales  -  what is the projection ?


   igc track plot(s)   






*/
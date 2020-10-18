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

include "debug"
include "hv"

  scriptDBOFF();

setmaxcodeerrors(-1); // just keep going
setmaxicerrors(-1);


AF=ofr(_clarg[1])

r= atoi(_clarg[2])
c= atoi(_clarg[3])


uint PH[3]

nir=vread(AF,PH,3,UINT_)
int npix = PH[0]

<<"$PH\n"
//uint MI[>10]

// should size MI to required



uint val = hex2dec("ffffffff")
wd = PH[1]
 ht = PH[2]
uint MI[PH[0]]
<<"%V $wd $ht \n"

nir=vread(AF,MI,wd*ht,UINT_)
cf(AF)

npc = 2400
npr = 2276
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
c += npc 
TIL = mtile(MI,r,c,nr,nc,1)
<<"extract $nr x $nc tile at $r $c\n"
B=ofw("tile2.dat")
wdata(B,PH)
wdata(B,TIL)
cf(B)

c += npc 
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


include "graphic"
include "gevent"

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
  
  vp =  cWi(@title,"PIC_WINDOW",@resize,0.01,0.01,0.9,0.95,0)

 //vp =  cWi(@title,"PIC_WINDOW",@pixresize,50,50,1850,950,0)


// again must be greater the 512x512 plus the borders
 
 picwo=cWo(vp,@GRAPH,@name,"Pic",@color,PINK_,@resize,2,20,602,820,1)

// set the clip to be 512x512 --- clipborder has to be on pixel outside of this!

 sWo(picwo,@border,@drawon,@clipborder,@fonthue,RED_, @redraw)

 sWo(picwo,@pixmapon,@drawoff,@save,@savepixmap,@redraw)

 rpicwo=cWo(vp,@GRAPH,@name,"RPic",@color,LILAC_,@resize,602,20,1202,820,1)

// set the clip to be 512x512 --- clipborder has to be on pixel outside of this!

 sWo(rpicwo,@border,@drawon,@clipborder,@fonthue,RED_, @redraw)

 sWo(rpicwo,@pixmapon,@drawoff,@save,@savepixmap,@redraw)

 pic3wo=cWo(vp,@GRAPH,@name,"Pic3",@color,TEAL_,@resize,1202,20,1802,820,1)

// set the clip to be 512x512 --- clipborder has to be on pixel outside of this!

 sWo(pic3wo,@border,@drawon,@clipborder,@fonthue,RED_, @redraw)

 sWo(pic3wo,@pixmapon,@drawoff,@save,@savepixmap,@redraw)


 

   int ncols = npc;
   int nrows = npr;
 
   uint  nbw;
   uchar Tile[]



   sWo(picwo,@clip,0,0,599,800,2)
   sWo(rpicwo,@clip,0,0,600,800,2)
      sWo(pic3wo,@clip,0,0,600,800,2)

  IC=WoGetClip(picwo)
<<"%V$IC\n"
  IC2=WoGetClip(rpicwo)
<<"%V$IC2\n"

   titleButtonsQRD(vp)
   titleVers();
   titleMsg("Sectional Tiles")

   sWi(vp,@redraw)
   

   sWo(picwo,@clearpixmap)
   sWo(rpicwo,@clearpixmap)
   sWo(pic3wo,@clearpixmap)

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



   PlotPixRect(picwo,Tile,cmi)
   sWo(picwo,@showpixmap)
  }

   if (reduce) {
   AVESPIX = imrgbave(RSPIX,5)
//   AVESPIX = RSPIX
//   <<"$SPIX[0][0:10] \n"
//   <<"$SPIX[10][0:10] \n"
//   <<"%X $SPIX[100][0:10] \n"
//   <<"%X $SPIX[200][0:10] \n"
// <<"300 %X $SPIX[300][0:10] \n"            

   <<" $(Cab(SPIX)) $(Cab(AVESPIX)) $(typeof(AVESPIX)) \n"
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
   RTile = RPIX;
//<<"$RTile[2][0:10] \n"   
   <<" $(Cab(RPIX)) $(Cab(RTile)) \n"
    PlotPixRect(picwo,RTile,0)
    sWo(picwo,@showpixmap)


   AVESPIX = imrgbave(RSPIX2,5)
   <<" $(Cab(SPIX)) $(Cab(AVESPIX)) $(typeof(AVESPIX)) \n"

   CMSPIX=rgbToColorIndex(AVESPIX,cmi,cmi+nc)
   nb= Cab(AVESPIX)
   redimn(CMSPIX,nb[0],nb[1])
   RPIX = mrevRows(CMSPIX)
   R5Tile = RPIX;
    PlotPixRect(rpicwo,R5Tile,0)
    sWo(rpicwo,@showpixmap)

   AVESPIX = imrgbave(RSPIX3,5)
   <<" $(Cab(SPIX)) $(Cab(AVESPIX)) $(typeof(AVESPIX)) \n"

   CMSPIX=rgbToColorIndex(AVESPIX,cmi,cmi+nc)
   nb= Cab(AVESPIX)
   redimn(CMSPIX,nb[0],nb[1])
   RPIX = mrevRows(CMSPIX)
   R5Tile = RPIX;
    PlotPixRect(pic3wo,R5Tile,0)
    sWo(pic3wo,@showpixmap)
  
   }




}








  while (1) {


     eventWait();
     ME=getMouseState()
<<"%6.2f $ME[7] $ME[8] $ME[9] $ME[10]\n"


  }
//%*********************************************** 
//*  @script plot-sectional-tiles.asl 
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

AF2=ofr(_clarg[2])


uint TH[6]

nir=vread(AF,TH,6,UINT_)

<<"%V$TH \n"

wd= TH[5]
ht = TH[4]

int npix = TH[5] * TH[6]

// should size MI to required

cstart = TH[1]

uchar MI[]
uchar MI2[]

nir=vread(AF,MI,wd*ht,UCHAR_)
cf(AF)


redimn(MI,ht,wd)

//TIL = mtile(MI,r,c,nr,nc,1)
//<<"extract $nr x $nc tile at $r $c\n"
TIL = MI;

nir=vread(AF2,TH,6,UINT_)

<<"%V$TH \n"
nir=vread(AF2,MI2,wd*ht,UCHAR_)
redimn(MI2,ht,wd)
TIL2 = MI2;
cf(AF2)


/// setup of color map


///   dat file
///   tile is n*m  of uint's -  each uint a XRGB  color pixel
///   option reduce 5x5 averager
//   convert input tile into matrix of cmap indices

//  cmp file
//  tile is already coded as cmap indices



 A= ofr("cmapi_den")
 
 CM= readRecord(A,_RTYPE,UINT_)

 cmb = Cab(CM)
 <<"$cmb\n"
 
 nc = cmb[0] 

#include "graphic"
#include "gevent.asl"

// CMAP

ngl = 256

cmi = 64
cindex = cmi

// this set up the cmap for the set of RGB values in orignal tiff file
// after a set if unique color values have been found
// typically less the 256 colors have been used
// so the original tiff file can be reduced to npix * char instead or npix *uint
for (i=0; i< nc; i++) {
   hexw= CM[i][1]
//<<"$i $cindex $hexw \n"
   setRGB(cindex,hexw,0)
    cindex++
}

// plot


  
  vp =  cWi(@title,"PIC_WINDOW",@resize,0.01,0.01,0.99,0.95,0)
 
  picwo=cWo(vp,@GRAPH,@name,"Pic",@color,PINK_,@resize,2,20,752,620,1)

  sWo(picwo,@border,@drawon,@clipborder,@fonthue,RED_, @redraw)

  sWo(picwo,@pixmapon,@drawoff,@save,@savepixmap,@redraw)


  pic2wo=cWo(vp,@GRAPH,@name,"Pic",@color,LILAC_,@resize,752,20,1554,620,1)

  sWo(pic2wo,@border,@drawon,@clipborder,@fonthue,RED_, @redraw)

  sWo(pic2wo,@pixmapon,@drawoff,@save,@savepixmap,@redraw)

   int ncols = TH[5];
   int nrows = TH[4];
 
   uint  nbw;
   uchar Tile[]

<<"%V$nrows $ncols\n"

   sWo(picwo,@clip,0,0,750,600,2)
   sWo(pic2wo,@clip,0,0,750,600,2)


  IC=WoGetClip(picwo)
<<"%V$IC\n"

   titleButtonsQRD(vp)
   titleVers();
   titleMsg("Sectional Tiles")

   sWi(vp,@redraw)
   

   sWo(picwo,@clearpixmap)


   
   //R5Tile = mrevRows(TIL)
     R5Tile =TIL

   <<" $(Cab(R5Tile)) $(typeof(R5Tile))\n"
   R5D= cab(R5Tile)
  <<"$R5D\n"
//   PlotPixRect(picwo,RPIX,cmi)

    sWo(picwo,@savepixmap,0,0,1500,750)
   T=fineTime()
   PlotPixRect(picwo,R5Tile,0)
   dt=fineTimeSince(T,1)
   <<" took $(dt/1000000.0) secs\n"
    sWo(picwo,@showpixmap)


   R5Tile =TIL2

    sWo(pic2wo,@savepixmap,0,0,1500,750)
   T=fineTime()
   PlotPixRect(pic2wo,R5Tile,0)
   dt=fineTimeSince(T,1)
   <<" took $(dt/1000000.0) secs\n"
    sWo(pic2wo,@showpixmap)


    updown = 0;
    rl = 0;
  while (1) {


     eventWait();
     ME=getMouseState()
//<<"%6.2f $ME[7] $ME[8] $ME[9] $ME[10]\n"
//<<"%V$_ebutton\n"
     if (_ebutton == RIGHT_) {

     rl += 10
     sWo(picwo,@scrollclip,RIGHT_,rl);
     sWo(pic2wo,@scrollclip,RIGHT_,rl);
     }
     if (_ebutton == LEFT_) {

     rl -= 10;
     sWo(picwo,@scrollclip,RIGHT_,rl);
     sWo(pic2wo,@scrollclip,RIGHT_,rl);     
     }

     if (_ebutton == UP_) {
     updown += 10;

     sWo(picwo,@scrollclip,UP_,updown);
     sWo(pic2wo,@scrollclip,UP_,updown);     
     }

     if (_ebutton == DOWN_) {
     updown -= 10;
     sWo(picwo,@scrollclip,UP_,updown);
     sWo(pic2wo,@scrollclip,UP_,updown);     
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
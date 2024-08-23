//
//
//

   fname = _clarg[1]
   if (fname == "") {
    <<" no data file via clarg !\n"
    exit(-1)
   }
     wcol = _clarg[2]
ycol = 0
if (wcol != "") {
  ycol = atoi(wcol)  
}
     A=ofr(fname);
     


allowDB("spe,vmf,plot,fop,svar,record,math,wcom",1) 
   wdb= DBaction(DBSTEP_)
Record RX;

RX.pinfo()

Nrecs=RX.readRecord(A,_RDEL,-1,_RTYPE,FLOAT_);

  chkIn()
  
 sz = Caz(RX);

  dmn = Cab(RX);
  dmn.pinfo()

  nrows = dmn[0]
  ncols = dmn[1]

  RX.pinfo()  // TBF should still be record_v type - fixed


  YV1 = RX[::][ycol]

  YV1.pinfo() // TBF should vec 1D sz 8 

 dim = Cab(YV1)
    sz = Caz(YV1)
    <<"%V $sz $dim\n"
    Redimn(YV1)
    YV1.pinfo()
    
    <<"%V $YV1[2] \n" // TBF prints YV1[0]
        <<"%V $YV1[0:-1] \n" // correct

 YV = RX[::][::]

  YV.pinfo()   // YV should be 2D dimn same as RX
dim = Cab(YV)
    sz = Caz(YV)
    <<"%V $sz $dim\n"

 kr = RX[2][1]

    <<"%V RX[2][1] $kr\n"
    for (i = 0 ; i <nrows; i++) {
     kr = RX[i][1]
    <<"[$i] $kr\n"
    }
<<"use YV gki\n"
   for (i = 0 ; i <nrows; i++) {
     gki = YV[i][2]
    <<"[$i] $gki\n"
    }

YV2 = RX[::][0:1:1]

  YV2.pinfo()   // YV should be 2D dimn same as RX
dim = Cab(YV2)
    sz = Caz(YV2)
    <<"%V $sz $dim\n"

//<<" YV2  $YV2 \n"

   YVC = "WD12"

    $YVC = RX[::][1:2:1]

    WD12.pinfo()
    
 <<"%V $WD12[0:-1:][0:-1:] \n"
dim = Cab(WD12)
    sz = Caz(WD12)
    <<"%V $sz $dim\n"



   YVC = "WV1"

    $YVC = RX[::][1]

    WV1.pinfo()
    
 <<" $WV1[0:-1:] \n"
dim = Cab(WV1)
    sz = Caz(WV1)
    <<"%V $sz $dim\n"

   YVC = "WV2"

    $YVC = RX[::][2]

 <<" $WV2[0:-1:] \n"

    NV = $YVC

    NV.pinfo()

// this should work as arg ptr ?
//sGl(_GLID, refgl, _glty, $YVC, _glcolor, GREEN_,_glsymline,DIAMOND_,_glusescales,0)
    
    MM = Stats(NV)

    MM.pinfo()

    MV = Stats($YVC)

    MV.pinfo()

 
ckkOut(1)

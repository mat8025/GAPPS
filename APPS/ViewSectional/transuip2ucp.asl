///
///
///




A= ofr("cmapi_den")     /// 
//A= ofr("cmapi")
 
 //CM= readRecord(A,@type,UINT_) ; // old

 CM= readRecord(A,_RTYPE,UINT_)

 cmb = Cab(CM)
 <<"$cmb\n"
 
 nc = cmb[0] 

  <<" $CM[::][::] \n"



//AF= ofr("chey97.dat")
//CF= ofw("chey97.cmp")
fname = _clarg[1]
datfile = "${fname}.dat"
cmpfile = "${fname}.cmp"

<<"%V $datfile $cmpfile \n"



AF= ofr(datfile)


uint PH[3];

nir=vread(AF,PH,3,UINT_);


int npix = PH[0];
int drows = PH[2];
int dcols = PH[1];

<<"%V $npix $drows $dcols \n"

CF= ofw(cmpfile)

wdata(CF,PH)

uchar CPIX[]
uint SPIX[]


  for (j=0;j<drows;j++) {
    reType(SPIX,UINT_)
    nir=  vread(AF,SPIX,dcols,UINT_)
    nec= vtrans(SPIX,CM)
// we could use uchar and have 512 colors in cmap
   vcmpset(SPIX,">",256,0)
    
    CPIX =SPIX;


//    <<"$CPIX[0:1000:50]\n"
    niw=wdata(CF,CPIX)
    if ( (j % 50) == 0) {
 <<"[$j ] $CPIX[0:500:50]\n"

    }
   // <<"$j $(Caz(SPIX)) $(typeof(SPIX)) $niw\n"
}




///////////// BUG ///////////////////
//<<"$CPIX[0:(dcols-1):10]\n"

// expression in range spec not parsed


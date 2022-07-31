/* 
 *  @script     transuip2ucp.asl                             
 * 
 *  @comment use cmap to produce coded tiff file                     
 *  @release Beryllium                                                  
 *  @vers 1.2 He Helium [asl 6.4.54 C-Be-Xe]                            
 *  @date 07/30/2022 09:34:24                                           
 *  @cdate Mon Aug 3 16:03:52 2020                                      
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2022 -->                               
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                  




A= ofr("cmap")     /// 
 
 //CM= readRecord(A,@type,UINT_) ; // old

 CM= readRecord(A,_RTYPE,UINT_)

 cmb = Cab(CM)
 <<"$cmb\n"
 
 nc = cmb[0] 
<<"$CM \n"
//  <<" $CM[::][::] \n"



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
!a
CF= ofw(cmpfile)

wdata(CF,PH)

uchar CPIX[]
uint SPIX[]


  for (j=0;j<drows;j++) {
    reType(SPIX,UINT_)
   // SPIX.pinfo();
    nir=  vread(AF,SPIX,dcols,UINT_);
//    <<"$nir $SPIX[0:10]\n"
    nec= vtrans(SPIX,CM)
//    <<" $SPIX[1000:2000]\n"
    //SPIX.pinfo();    
    
// we could use uchar and have 512 colors in cmap
   vcmpset(SPIX,">",256,0)
    
    CPIX =SPIX;
//<<" $CPIX[1000:2000]\n"

//    <<"$CPIX[0:1000:50]\n"
    niw=wdata(CF,CPIX)
    if ( (j % 500) == 0) {
 <<"[$j ] $CPIX[0:500:50]\n"
    }
   // <<"$j $(Caz(SPIX)) $(typeof(SPIX)) $niw\n"
}




///////////// BUG ///////////////////
//<<"$CPIX[0:(dcols-1):10]\n"

// expression in range spec not parsed


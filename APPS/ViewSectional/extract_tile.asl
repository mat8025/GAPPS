/* 
 *  @script extract_tile.asl 
 * 
 *  @comment extract a tile rxc from sectional 
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.4.54 C-Be-Xe]                               
 *  @date 07/30/2022 13:12:35 
 *  @cdate 07/30/2022 13:12:35 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//-----------------<v_&_v>------------------------//;

Str Use_= "asl extract_tile xyz.dat tile.dat row col  [nrows ncols]";


#include "debug" 
  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

   allowErrors(-1); 

  chkIn(_dblevel)

  chkT(1);

///
//// pull out subset of dat file 
////


int r=2000;
int c= 0;

Str fname = _clarg[1];

AF=ofr(fname)

Str tilename = _clarg[2];


/*
ra = _clarg[2];
ra.pinfo()
ca = _clarg[3];
ca.pinfo()
*/

int nr = 1024;
int nc = 1024;

int na = argc();
int ac = 3;

r= atoi(_clarg[ac++])
c= atoi(_clarg[ac++])



<<"$na \n";

if (na > 5) {

 nr= atoi(_clarg[ac++])
 nc= atoi(_clarg[ac++])

}

<<"$fname $AF $tilename  $r $c $nr $nc\n"


uint PH[3];

nir=vread(AF,PH,3,UINT_)
int npix = PH[0];

<<"PH $PH\n"
//uint MI[>10]

// should size MI to required

uint val = hex2dec("ffffffff")
int wd = PH[1]
int ht = PH[2]

nrows = 5000

uint MI[PH[0]]


nir=vread(AF,MI,wd*ht,UINT_)


redimn(MI,ht,wd)

//TIL = mtile(MI,r,c,nr,nc,1)

 TIL = submat(MI,r,c,nr,nc,1);

<<"extracting tile $tilename $nr x $nc  at postion row $r column $c  from $fname\n"
!a


 B=ofw("${tilename}.dat")


PH[0] = nr * nc;
PH[1] = nc;
PH[2] = nr;

<<"out $PH \n"

 wdata(B,PH)
 wdata(B,TIL)

 cf(B)

!!"ls -l tile*.dat"


exit();

////////////////////////////// TODO //////////////////////////
//
// option to just take original size of sectional tiff
// and split it into n 1024x1024 tiles
// ? overlap by 512?
//
//
///////////////////////////////////////////////////////////////////
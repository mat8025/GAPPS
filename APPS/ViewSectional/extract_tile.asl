///
//// pull out subset of dat file 
////


r=2000;
c=1200;

Str fname = _clarg[1];

AF=ofr(fname)

ra = _clarg[2];
ra.pinfo()
ca = _clarg[3];

ca.pinfo()

r= atoi(_clarg[2])
c= atoi(_clarg[3])

<<"$fname $AF $ra $ca $r $c \n"


uint PH[3]

nir=vread(AF,PH,3,UINT_)
int npix = PH[0]

<<"PH $PH\n"
//uint MI[>10]

// should size MI to required



uint val = hex2dec("ffffffff")
int wd = PH[1]
int ht = PH[2]

nrows = 5000

uint MI[PH[0]]


nir=vread(AF,MI,wd*ht,UINT_)



nr = 1024;
nc = 1024;

redimn(MI,ht,wd)

//TIL = mtile(MI,r,c,nr,nc,1)
TIL = submat(MI,r,c,nr,nc,1)
<<"extract $nr x $nc tile at $r $c\n"



B=ofw("tile1.dat")
PH[0] = nr * nc;
PH[1] = nc;
PH[2] = nr;

<<"out $PH \n"

wdata(B,PH)
wdata(B,TIL)

cf(B)

<<"DONE\n"


exit();


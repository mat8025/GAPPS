

int YCOL[10+];
float YV[];
float XV[];
float CLIMB[];
float FP[];
float MM[];

float altmax;
float altmin; 
float fpymax;
float fpymin;

float xmax;
float xmin;
float xpad;
float R[];


 R= vgen(INT_,2000,0,1)

 Redimn(R,500,4)

setdebug(1)
proc readCompute()
{
  static int j = 0;



<<"cat test_case${tc}.ip | asl fp_fcV8.asl > test_case.op \n"

//    !!"cat test_case${tc}.ip | asl fp_fcV8.asl > test_case${tc}.op"

 //   sleep(1)

// A= ofr("test_case${tc}.op")

 ncols = 2

 YCOL[0] = 0
 int ac =2
 int i = 0


 i = 1
 ncols = i
 pars = i

  //<<" $YCOL \n"

 ycol = 1

// first line is comment
// Redimn(R)




<<"%V$tc \n"
<<"%V$R[0][0] \n"
<<"%V$R[1][1] \n"

<<"%(4,, ,\n)%V$R[0:3][::] \n"
 sz = Caz(R)


     dmn = Cab(R)

     nrows = dmn[0]

<<"%V$nrows \n"

<<"%V$sz $dmn\n"

ncols = dmn[1]

<<"%V$ncols \n"

// tim 

  sz = Caz(R)

// check # cols
/{
  XV = R[::][0]

  Redimn(XV)
  sz = Caz(XV)
  dmn = Cab(XV)

  <<"xsz $sz $dmn\n"

  XMM = Stats(XV)

  <<"%6.2f$(typeof(XMM)) $XMM \n"

  xmin = XMM[5]

  xmax = XMM[6]

  xrange = fabs(xmax-xmin)
 
  xpad=xrange * 0.05

<<"%V6.4f${XV[0:20]} \n"
/}


  sz = Caz(YV)
  dmn = Cab(YV)
  <<"ysz $sz $dmn\n"


   
  j++


   YV = R


//XIC  fully specified does not work

  xic (0) 
  YV = R[0:49:1][1]


  sz = Caz(YV)
  dmn = Cab(YV)
  <<"ysz $sz $dmn\n"

<<"%V6.4f$YV[0:20] \n"


// -1 don't work
  NYV = R[0:-1:1][1]

  sz = Caz(NYV)
  dmn = Cab(NYV)
  <<"ysz $sz $dmn\n"

<<"%V6.4f$NYV[0:20] \n"




// XIC defaults don't work

  MYV = R[::][1]

  sz = Caz(MYV)
  dmn = Cab(MYV)
  <<"ysz $sz $dmn\n"

<<"%V6.4f$MYV \n"


<<"DONE COMPUTE \n"   
  xic (1)
}



  tc = 1
  readCompute()
  tc =2 
  readCompute()
  tc =3
  readCompute()

  tc =4
  readCompute() 




stop!
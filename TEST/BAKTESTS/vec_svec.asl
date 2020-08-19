

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

setdebug(1)

  R= vgen(INT_,2000,0,1);

//Redimn(R,500,4);

 

 sz = Caz(R)


     dmn = Cab(R)

     nrows = dmn[0]

<<"%V$nrows \n"

<<"%V$sz $dmn\n"

   //ncols = dmn[1]

<<"%V$ncols \n"

// tim 

  sz = Caz(R)

  YV = R[0:49:1]
  sz = Caz(YV)
  dmn = Cab(YV)
  <<"ysz $sz $dmn\n"

<<"%(10,, ,\n)6.1f$YV[0:19] \n"


  XV = R[::2]
  sz = Caz(XV)
  dmn = Cab(XV)
  <<" $sz $dmn\n"

<<"%(10,, ,\n)6.1f$XV[0:19] \n"


  XV = R[9:-1:2]
  sz = Caz(XV)
  dmn = Cab(XV)
  <<" $sz $dmn\n"

<<"%(10,, ,\n)6.1f$XV[0:19] \n"



// -1 don't work
  NYV = R[0:-1:1]

  sz = Caz(NYV)
  dmn = Cab(NYV)
  <<"ysz $sz $dmn\n"

<<"%V6.1f$NYV[0:20] \n"

// XIC defaults don't work

  MYV = R[::]

  sz = Caz(MYV)
  dmn = Cab(MYV)
  <<"ysz $sz $dmn\n"

<<"%V6.1f$MYV[0:19:1] \n"
   // FIXIT rdp not work xic does
<<"%V6.1f$MYV[19:0:-1] \n"





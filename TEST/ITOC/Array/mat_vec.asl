

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

  sz = Caz(R) ;  dmn = Cab(R) ; nd = Cnd(R)

<<"%V$sz $dmn $nd \n"


  NR = Redimn(R,500,4);

  sz = Caz(R) ;  dmn = Cab(R) ; nd = Cnd(R)

<<"R is %V$sz $dmn $nd \n"


  sz = Caz(NR) ;  dmn = Cab(NR) ; nd = Cnd(NR)

<<"NR is %V$sz $dmn $nd \n"



  nrows = dmn[0]

<<"%V$nrows \n"

<<"%V$sz $dmn\n"

<<"%(10,, ,\n)6.1f$R[0:19][0] \n"
<<"%(10,, ,\n)6.1f$R[0:19][1] \n"

j = 2

<<"%(10,, ,\n)6.1f$R[0:19][j] \n"
j++

<<"%(10,, ,\n)6.1f$R[0:19][j] \n"



ncols = dmn[1]

<<"%V$ncols \n"

// tim 

  sz = Caz(R) ;  dmn = Cab(R) ; nd = Cnd(R)

<<"%V$sz $dmn $nd \n"

<<"%(4,, ,\n)6.1f$R[0:4][::] \n"


//YV = Redimn(R[0:49:1][1])
YV = R[0:49:1][1]
// YV = R[0:49:1][1]

  Redimn(YV)

  sz = Caz(YV)
  dmn = Cab(YV)
  nd = Cnd(YV)
<<"ysz $sz nd $nd  DMN $dmn\n"
// FIX we defined YV to be nd of 1 so it should remain so


  sz = Caz(R) ;  dmn = Cab(R) ; nd = Cnd(R)

<<"%V$sz $dmn $nd \n"

//<<"%(10,, ,\n)6.1f$YV[0:19][0] \n"
<<"%(10,, ,\n)6.1f$YV[0:19] \n"

<<"%(4,, ,\n)6.1f$R[0:4][::] \n"

stop!

  NYV = R[0:49:1][1]

  sz = Caz(NYV)
  dmn = Cab(NYV)
  nd = Cnd(NYV)
<<"nysz $sz nd $nd  DMN $dmn\n"
// NYV is created so it becomes a one column matrix 

<<"%(10,, ,\n)6.1f$NYV[0:19][0] \n"


stop!



// -1 don't work
  NYV = R[0:-1:1][1]

  sz = Caz(NYV)
  dmn = Cab(NYV)
  <<"ysz $sz $dmn\n"
//  Redimn(NYV)
<<"%V6.4f$NYV[0:20][0] \n"

stop!

// XIC defaults don't work

  MYV = R[::][1]

  sz = Caz(MYV)
  dmn = Cab(MYV)
  <<"ysz $sz $dmn\n"

<<"%V6.4f$MYV \n"





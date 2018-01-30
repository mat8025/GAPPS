///
///
///


setdebug(1,"keep","trace")
filterDebug(0,"DynamicExpand")


//proc fvec (Z[], X[], Y[], n)

proc foov ()
{
  <<"no tanto \n"
}
//====================

proc fvec (int Z[], int X[], int Y[], int n) // OK ?

{
<<"$Z[0] $Z[1]\n"
int k= n;
for (i = 0; i < n ; i++) {

  Z[i] = X[i] + Y[i];
   zsz = Caz(Z);
   znd = Cab(Z);
<<"%V$i $zsz $znd $X[i] $Y[i] $Z[i]\n"

}


<<"no tanto $k $n\n"
<<"%V $X\n"

//<<"$X\n"

R = X;
rsz= Caz(R)
<<"%V$rsz $R\n" 
<<"%V $Y\n"
//<<"%V $Z[::]\n" // xic

<<"%V $Z[0] $Z[1] \n"

<<"%V $Z[::]\n" // xic

<<" proc exit\n";


}


checkIn()

sz = 15

int x[] = vgen(INT_,sz,0,1)   //   PASS

xsz= Caz(x)
<<"%V$xsz $x\n"
  
//int y[] = vgen(INT_,sz,sz,1)
//int y[];

y= vgen(INT_,sz,sz,1)

ysz= Caz(y)
<<"%V$ysz $y\n"

//int c[20]  // FIX

int c[];  //  TBF - WORKS

//int c[2+]; // WORKS

nd = Cab(c)
csz= Caz(c)
<<"%V $csz $nd\n"




c[0] = 79;
c[1]= 47;
c[2]= 80;

nd = Cab(c)
csz= Caz(c)
<<"%V $csz $nd\n"

checkNum(x[1],1)

foov()

<<"$c\n"

fvec(c,x,y,sz);

<<"done proc \n"

<<"%V $c[0] $c[sz-1]\n"

<<"%V $c\n"


checkNum(c[0],sz)
val = sz-1 + 2*sz-1;
<<"%V $val\n"
checkNum(c[sz-1],val)

checkOut()

/{
// TBF

1 int c[] //  DONE

2 int x[] = vgen(INT_,sz,0,1)   // fix should be a dynamic array  DONE

3 proc fvec (int Z[], int X[], int Y[], n) // works   

4 ? proc fvec (generic Y[],  gnum X[], gnum Z[], n) // not coded


  5 <<"%V $X[::]\n" // works

  6 xic fails @ proc end!! // fixed --was xic oncorrect stack problem

/}
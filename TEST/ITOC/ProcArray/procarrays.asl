///
/// # test proc arrays
///



setdebug(0)

checkIn()

//proc sumarg(int V[], int U[])
proc sumarg(V,  U)
{
<<"in $_proc\n"

<<" %V $V \n"

<<" %V $U \n"


<<"type $(typeof(V)) sz $(Caz(V)) \n"

<<"type $(typeof(U)) sz $(Caz(U)) \n"

//   a = V[2]
//   b = U[2]

//<<"%V $a $b\n"

   Z = V + U

<<" %v $Z \n"
  return Z

}
///


X = Igen(10,0,1)
Y = Igen(10,9,2)

 <<" %V $X \n"

 <<" %V $Y \n"

 <<"type  $(typeof(X)) sz $(Caz(X)) \n"

 W = X + Y

<<"\n%V $W \n"

 <<"type  $(typeof(W)) sz $(Caz(W)) \n"

  S=sumarg(X,Y)


 <<"\n%V $S \n"
 <<"type  $(typeof(S)) sz $(Caz(S)) \n"

Y[9] = 31
Y[0] = 47
X[9] = 66;
X[0] = 79;

<<"%V $Y\n"
<<"%V $X\n"


  S=sumarg(X,Y)

 <<"\n%V $S \n"

checkNum(S[9],97)


 T = X[0:5] + Y[1:6]

<<"\n%V $T \n"

 <<"type  $(typeof(T)) sz $(Caz(T)) \n"
X[9] = 69;

  S=sumarg(X,Y)

checkNum(S[9],100)

checkOut()

stop!


////////////////////////////////////////////////////////////


proc do_DBBUF( DBBUF, bname)
{ 


//    recast(DBBUF,"char")
//    DBBUF = MB
//    recast(DBBUF,"int")
//     swab(DBBUF)
      
<<" $bname %d $DBBUF[0] \n"

      for (i = 1; i < 10; i++) {
         DBBUF[i] = GIV[i]
      }
#{
      if (getWoValue(pt_id_wo) @= bname) {
        setgwob(wo_array,@VALUE,&DBBUF[0],"update")
        setgwob(wo_array[0],@VALUE,"%x $DBBUF[0]","update")
      }
#}

}

int PFIV[20]
int SPIV[20]

int GIV[20]
 
  PFIV[0] = 79
  SPIV[0] = 47

        for (j = 1; j < 10; j++) {
          GIV[j] = j * 3
        }

        do_DBBUF(SPIV,"SP")

<<"%V $SPIV \n"

        

<<"%V $PFIV \n"

        for (j = 1; j < 10; j++) {
          GIV[j] = j * 4
        }

do_DBBUF(PFIV,"PF")


<<"%V $PFIV \n"

        for (j = 1; j < 10; j++) {
          GIV[j] = j * 5
        }

        do_DBBUF(PFIV,"PF")

<<"%V $PFIV \n"

        for (j = 1; j < 10; j++) {
          GIV[j] = j * 6
        }

        do_DBBUF(SPIV,"SP")

<<"%V $SPIV \n"
<<"%V $PFIV \n"


STOP("DONE \n")

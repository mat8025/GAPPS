///
/// Mlip
///



//  
set_debug(1)

   R= Fgen(20,1,1)

 <<"%v \n $R \n"

   Redimn(R,5,4)

   T = transpose(R)

 <<"%v%r%6.2f \n $R \n"



<<" %v $(Cab(R)) \n"

 <<"%v%6.2f \n $T \n"

<<" %v $(Cab(T)) \n"

  V= Fgen(5,0.5,0.5)

//  Redimn(V,1,5)

<<"\n %v%6.2f \n $V \n"

  NX= Fgen(15,0.5,0.12)

<<"\n %v%6.2f \n $NX \n"
  
 C= Mlip(NX,T,V)
      // C= Mcspline(NX,T,V)

<<" %v $(Cab(C)) \n"

<<"\n %v%6.2f \n $C \n"


  D= transpose(C)

<<"\n %v%6.2f \n $D \n"


STOP("DONE \n")



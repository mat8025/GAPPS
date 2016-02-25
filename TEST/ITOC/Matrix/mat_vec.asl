
//  
set_debug(0)

   R= Igen(10,1,1)

 <<"%v \n $R \n"

  Redimn(R,5,2)

 <<"%(2,|, ,|\n)$R \n"

  T= Igen(10,3,1)


<<"$(Cab(T)) $(Caz(T))\n"


  Redimn(T,5,2)

<<"%(2,|, ,|\n)$T \n"

  C= R + T

<<"%(2,|, ,|\n)$C \n"

  C = C + 3

<<"%(2,|, ,|\n)$C \n"

  V= Igen(2,4,1)

<<"V $(Cab(V)) $(Caz(V))\n"

  VC = C + V

<<"%(2,|, ,|\n)$VC \n"


  VM = C * V

<<"%(2,|, ,|\n)$VM \n"


STOP("DONE \n")



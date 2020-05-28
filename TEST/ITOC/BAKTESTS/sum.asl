// flipdim --- reverses along a dimension

setdebug(1)

// vector ?



// 2D

R = vgen(INT_,12,0,1)

<<"$R\n"

 S = sum(R)

<<" Sum(R) \n"
<<"$S\n"

 Redimn(R,3,4)
T= R
<<"$T\n"
/{
<<"R dimns $(cab(R)) = \n"
<<"$R"
<<"flipDim(R,0)\n"
T= flipDim(R,0)
<<"$T"
<<"flipDim(R,1)\n"
T= flipDim(R,1)
<<"$T\n"
/}

 S = sum(R)

<<" Sum(R) \n"
<<"$S\n"

 S = sum(R,0)

<<" Sum(R) \n"
<<"$S\n"


 C = sum(R,1)

<<" Sum(R) \n"
<<"$C\n"
b = Cab(C)
<<"$b\n"

 Redimn(R,6,2)
T= R
<<"$T\n"

 S = sum(T)

<<"$S\n"

<<"$R"
  t=R->flipDim(0)
<<"$R"
<<"%V$t\n"


 S = sum(T,0)

<<"ondim0 --- $S\n"

 S = sum(T,1)

<<"ondim1 $S\n"


stop!
// 3D

R = vgen(INT_,12,0,1)
<<"$R\n"

 Redimn(R,2,3,2)

<<"%df$R\n"

 flipDim(R,0)

<<"$R\n"


 flipDim(R,1)

<<"$R\n"


 flipDim(R,2)

<<"$R\n"




// 4D
<<" 4D \n"
R = vgen(INT_,24,0,1)
<<"$R\n"


 Redimn(R,2,2,3,2)

<<"$R\n"
T= R

 flipDim(R,0)

<<"$R\n"

R= T

<<"flipping along 1 \n"

 flipDim(R,1)

<<"$R\n"


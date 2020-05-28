// flipdim --- reverses along a dimension

setdebug(1)

// vector ?



// 2D

R = vgen(INT_,12,0,1)
<<"$R\n"

 Redimn(R,3,4)

T= R

<<"R dimns $(cab(R)) = \n"
<<"$R"
<<"flipDim(R,0)\n"
T= flipDim(R,0)
<<"$T"
<<"flipDim(R,1)\n"
T= flipDim(R,1)

<<"$T\n"

exit()

 S = sum(R)
<<" Sum(R) \n"
<<"$S\n"

<<"$R"
  t=R->flipDim(0)
<<"$R"
<<"%V$t\n"

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


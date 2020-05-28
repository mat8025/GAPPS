

 H = vgen(FLOAT_,30,0,1)


 Ke = (1.356 + 0.1296 * H) / (1 + 0.1318 * H)


//<<"%6.4f$Ke \n"

 J = H @+ Ke


//<<"%6.4f$J \n"

 J->redimn(2,30)

 R = Transpose(J)

<<"%(2,, ,\n)6.4f$R"

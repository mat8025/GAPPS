


//proc log_me( vec)

proc log_me(float vec[])
{
<<"proc $_proc input is :-\n %6.2f$vec\n"  
  vec = Log10(vec)
<<"proc $_proc output is :-\n %6.2f$vec\n"
}

N = 10

V = vgen(FLOAT_,N,0.1,1)


<<"%6.2f$V\n"


 Z = V

<<"%6.2f$Z\n"


  log_me(Z)

<<"proc returned output is :-\n"
<<"%6.2f$Z\n"

 Z = V

  log_me(&Z[2])


<<"proc returned output is :-\n"
<<"%6.2f$Z\n"


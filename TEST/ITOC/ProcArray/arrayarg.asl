
N = 10

proc read_sp(float wsp[])
{
 int nr
    nr = v_read(A,wsp,N)



<<"%(10,, ,\n)6.1f$wsp \n"

// FIXME!
    wsp +=  1.0
    wsp = Log10(wsp)

<<"%(10,, ,\n)6.3f$wsp \n"

<<"%V$nr \n"

    return nr
}


proc log_me( vec)
{
<<"proc $_proc input is :-\n $vec\n"  
  vec = Log10(vec)
<<"proc $_proc output is :-\n $vec\n"
}


proc addc_me( vec)
{
<<"proc $_proc input is :-\n $vec\n"  
  vec += 2
<<"proc $_proc output is :-\n $vec\n"
}


proc addclog_me( vec)
{
<<"proc $_proc input is :-\n $vec\n"  
  vec += 2
  vec = Log10(vec)
<<"proc $_proc output is :-\n $vec\n"
}



proc addcthenlog_me( vec)
{
<<"proc $_proc input is :-\n $vec\n"  
  vec += 2
  vec = log_me(vec)
<<"proc $_proc output is :-\n $vec\n"
}




float sp1[N]


V = vgen(FLOAT_,N,0.1,1)


<<"$V\n"

 Z = V

<<"$Z\n"


  log_me(Z)

<<"proc returned output is :-\n"
<<"$Z\n"


  addc_me(Z)

<<"proc returned output is :-\n"
<<"$Z\n"


 Z = V

  addclog_me(Z)

<<"proc returned output is :-\n"
<<"$Z\n"


 Z = V

  addcthenlog_me(Z)

<<"proc returned output is :-\n"
<<"$Z\n"




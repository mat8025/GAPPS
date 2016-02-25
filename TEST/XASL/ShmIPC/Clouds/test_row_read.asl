
const float nm2km = 1.852
const float km2nm = 1.0/nm2km


proc nextCloud()
{

  fseek(A,0,0)
  

  RL= readRecord(A,@del,',')


b = Cab(RL)

<<"$b\n"

nc = b[1]

<<"$RL[0][0] $RL[0][nc-1] \n" 

}

float PA[]

proc getPeakDBZAlt(sr, er)
{

// given sub-range find peak DBZ and range as function of alt
//
// use LR reflect array

     Palt = Alt

 <<"%V$Alt $Palt $sr $er\n"

     PA = RL[Palt][::]

b = Cab(RL)

<<"RL_bounds %V$b \n"
b = Cab(PA)
<<"PA_bounds %V$b \n"

     Redimn(PA)

b = Cab(PA)

<<"PA_bounds %V$b \n"

     mmi = minmaxi(PA)

     PkDBZrange = (mmi[1] * 1.2 * km2nm) 

<<"%V$PkDBZrange \n"
<<"MMI $mmi $PA[mmi[0]] $PA[mmi[1]]\n"



} 


int Alt = 0
int Palt = 0


float RL[]

fn = _clarg[1]
  A= ofr(fn)



  RL= readRecord(A,@del,',',3)


b = Cab(RL)

<<"$b\n"

nc = b[1]

<<"$RL[0][0] $RL[0][nc-1] \n" 


nextCloud()

getPeakDBZAlt(10, 50)

nextCloud()

Alt++

getPeakDBZAlt(10, 50)


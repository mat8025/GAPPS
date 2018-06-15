///
///
///


A= ofr(_clarg[1])


R= readrecord(A,@del,',');
//R= readrecord(A,@del,-1);

<<"$(typeof(R)) $(Caz(R))   $(Caz(R,0))\n"

ans= iread()

for (i = 0; i < 10 ; i++)  {
 <<"<$i> $R[i]\n"
}

//<<"<$R[0][0]> <$R[0][1]> \n"

B=ofw("junk")
 writerecord(B,R,@del,-1)


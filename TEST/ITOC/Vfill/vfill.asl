///
///  vfill
///

/{/*
vfill
vfill (vec,N, start_index, start_value, incr_value, stepindex);
fills vector with values 
vfill(vec,Nvalues, [start_index], [start_value], [incr_value], [stepindex]);
can be used to zero vector or section of vector,
or generate a ramp of values.

/}*/

chkIn()

N= 100;
IV = vgen(INT_,N,0,1)


chkN(IV[1],1);
chkN(IV[19],19);

<<"$IV[0:19]\n"

 vfill(IV,5,3,47,1,1)

<<"$IV[0:19]\n"

N= 100;
FV = vgen(FLOAT_,N,0,1)

vfill(FV,6,4,79,-1,1)

<<"%6.1f$FV[0:19]\n"

chkR(FV[4],79);
chkR(FV[5],78);


chkOut()

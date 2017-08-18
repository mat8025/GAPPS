///
///  crude dwnsample 48 ->16
///


// pick every 3rd

fn = _clarg[1];
<<"$fn\n"
A=ofr(fn)
if (A == -1)
 exit()


 R=rdata(A,"short");
cf(A)

 sz= Caz(R)
 <<"read $sz shorts\n";

<<"$R[0:10]\n"
 T= R[0:-1:3];
<<"$T[0:10]\n"

A=ofw("${fn}.ds")

nw=wdata(A,T);

<<"wrote $nw shorts\n";



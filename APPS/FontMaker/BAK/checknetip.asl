///
/// check pats
///


  A=ofr("alptrip.dat")
  B=ofr("alptrop.dat")
int k = 0;
int j = 0;
 char c = 64;
 
 while (1) {
 k++;
if ((j%5) ==0)
  c++;
 T= rdata(A,FLOAT_,100)
  <<"//$k/// %c$c////////\n"
 <<"%(10,, ,,\n)3.0f$T\n"
 <<"//$k/// %c$c////////\n"
  P= rdata(B,FLOAT_,26)
  <<"%3.0f $P\n"
  
ans= iread();

if (ans @= "q")
   exit()
   
 if (k == 130)
   break
  j++
  
}
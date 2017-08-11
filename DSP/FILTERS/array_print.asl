///




  AMP = vgen(FLOAT_,500,0,1)

setdebug(1);
fb=ofw("op_mag")
<<" file handel $fb\n"
for (i = 0; i< 500; i++) {
     ma = i;
     AMP[i] = ma;
 <<[fb]" $i,  $ma\n";    
  }

<<"AMP:: $AMP[0]\n"
<<"$AMP\n\n"
  fflush(fb);
  //cf(fb);
  
n = 10;
<<" now the row print\n";
<<" file handle $fb\n"
<<" %3.1f%($n,->,\s,<-\n)$AMP\n"





<<"$AMP[499] $(typeof(AMP)) $(Cab(AMP))\n"

<<[fb]"  2026 \n";    

cf(fb);
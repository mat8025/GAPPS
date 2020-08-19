
chkIn(_dblevel)

dv = vgen(DOUBLE_,10,0,1);  
<<"$dv\n"

fv[] = vgen(FLOAT_,10,0,1);  // crash TBF [] is not required 
<<"$dv\n"






cmplx a
a->set(2.5,0.5)
a->info(1)



val = 90.0;
cmplx g[10] = {1,-2,3,-4,5,-6,7,-8,9,-10};

sz = Caz(g)
<<"%V$sz $g\n"
g->info(1)


 g[3]->Set(47,79)

<<"$g[3]\n"


  g[4]->setReal(val);


<<"$g[4] \n"

  g[4]->setReal(80);


<<"$g[4] \n"

hc = vgen(CMPLX_,10,0,1)

<<"$hc \n"

hc->info(1)


exit()
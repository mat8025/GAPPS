


proc getSignalSpecs()
{

  dsz= Caz(BV);

<<"%V $dsz  $BV[0:5]\n";

  YS = BV;

<<"%V %(10,,\s,\n)%6.2f${YS[0:(dsz-1):]}\n"
}


short BV[];

float YS[];



  BV = vgen(SHORT_,200,0,1);
  <<"%BV[0:19]\n";

  getSignalSpecs();


  BV = vgen(SHORT_,200,0,-1);


  getSignalSpecs();

exit();
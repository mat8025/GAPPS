#/* -*- c -*- */
# 
# interactively kill named programs

zapp= _clarg[1];

<<"zapping $zapp \n"

yn = "y"

  svar A;
  
A =!!"ps -ef"
  
 nl = Caz(A);

<<"$nl processes\n"  

int pid = -1

mypid=getAslPid()

  //<<"%V $mypid $_clarg[1]  $_clarg[2] \n"

  nl = Caz(A);

//<<"ps $nl lines - which are $zapp ? \n"
  //<<"$A[0] $A[1]\n"
  //<<"%(,,\n,,)$A[0:5] \n"

match = 0;

  for (i = 0; i < nl ; i++) {

    C=Split(A[i]);
    lsz = Caz(C);
    //   <<" ${C[1]} \n"

    spat(C[7],zapp,1,1,&match);
    smatch = 0;
      // <<" $lsz ${C[5]} \n"
      if ( ! (C[5] @= "")) {
	//      <<" ${C[*]} \n"
        spat(C[5],zapp,1,1,&smatch);
      }
 if(match || smatch) {
    pid = C[1];
    if (pid != mypid) {
      <<" found process $C[1] id $C[0] \n";
      <<" ${C[::]} \n";

      yn=ttyin(" Kill [n/y]?");

  if (yn @= "y") { // line has \n ?
    <<"Killing $pid \n";
    !!"kill  $pid ";
    }
   }
 }
}





STOP!

#/* -*- c -*- */
# 
# interactively kill named programs

zapp= _clarg[1]
<<"zapping $zapp \n"

yn = "y"
A=!!"ps wax"

int pid = -1

mypid=getAslPid()

<<"%V $mypid $_clarg[1]  $_clarg[2] \n"

  nl = Caz(A)

match = 0

  for (i = 1; i < nl ; i++) {

    C=Split(A[i]);
    lsz = Caz(C);
      //    <<" ${C[*]} \n"

    spat(C[4],zapp,1,1,&match);
    smatch = 0;
      // <<" $lsz ${C[5]} \n"
      if ( ! (C[5] @= "")) {
	//      <<" ${C[*]} \n"
        spat(C[5],zapp,1,1,&smatch);
      }
 if(match || smatch) {
    pid = C[0];
    if (pid != mypid) {
      <<" found process $C[4] id $C[0] \n";
      <<" ${C[*]} \n";

      yn=ttyin(" Kill [n/y]?");

  if (yn @= "y\n") { // line has \n ?
    <<"Killing $pid \n";
    !!" kill -9 $pid ";
    }
   }
 }
}





STOP!

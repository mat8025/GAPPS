#/* -*- c -*- */
# 
# interactively kill named programs

setDebug(1,@keep,@filter,0)

zapp= _clarg[1];

<<"zapping $zapp \n"

yn = "y"

  svar A;
  
A =!!"ps -auwx"
  
 nl = Caz(A);

<<"$nl processes\n"  
<<"%(1,,,\n)$A\n"

int pid = -1

mypid=getAslPid()

  <<"%V $mypid $_clarg[1]  $_clarg[2] \n"

  nl = Caz(A);

//<<"ps $nl lines - which are $zapp ? \n"
  //<<"$A[0] $A[1]\n"
  //<<"%(,,\n,,)$A[0:5] \n"

match = 0;

  for (i = 0; i < nl ; i++) {

    C=Split(A[i]);
    lsz = Caz(C);
    //   <<" ${C[1]} \n"

    spat(C[10],zapp,1,1,&match);
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
      <<" %(1, , ,,)${C[::]} \n";

      // yn=ttyin(" Kill [n/y]?");

      yn=iread(" Kill [n/y]?");

        if (yn @= "y") { // line has \n ?
    <<"Killing $pid \n";
    !!"kill -9 $pid ";
       }
   }
 }
}





exit()

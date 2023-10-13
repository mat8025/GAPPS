/* 
 *  @script zap.asl 
 * 
 *  @comment interactively kill named processes 
 *  @release CARBON 
 *  @vers 1.3 Li Lithium [asl ]                                             
 *  @date 10/11/2023 16:17:58 
 *  @cdate 1/1/2007 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 
 * 
 */ 
//-----------------<v_&_v>------------------------//


// TBF 10/11/23 bug   @= strcmp  but == opera eqv does not also do strcmp
// if LHS and RHS are strings


  na = argc()

<<" $na $_clarg\n"
  ask = 0;
  ans  = "y"

<<"arg 0 $_clarg[0]\n"
<<"arg 1 $_clarg[1]\n"
<<"arg 2 $_clarg[2]\n"

  
  if (_clarg[1] @= "-i" ) {
    ask = 1;
   zapp= _clarg[2];
   ans  = "n"
   }
  else {
    zapp= _clarg[1];
  }


  <<"zapping $zapp \n"

   

  Svar A;





!!"ps -auwx > ps_list_tmp"

// A = readFile("ps_list_tmp")
  A.readFile("ps_list_tmp") // should also work TBD 10/11/23
 nl = Caz(A);

<<"$nl processes\n"  
//<<"%(1,,,\n)$A\n"

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
    pid = atoi(C[1]);
    if (pid != mypid) {
      <<" found process $pid $C[1] id $C[0] \n";
      <<" %(1, , ,,)${C[::]} \n";

      // yn=ttyin(" Kill [n/y]?");

      //yn=iread(" Kill [n/y]?");

  if (ask) { 
     ans = query(" kill ? [y,n,q] ${C[::]} ")
   }
   
     if (ans == "q") {
         exit(-1)
     }


     if (ans @= "y") { // line has \n ?
    <<"Killing $pid \n";
    !!"kill -9 $pid ";
     }


   }
 }
}





exit(-1)

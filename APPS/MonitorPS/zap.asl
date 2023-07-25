/* 
 *  @script zap.asl 
 * 
 *  @comment interactively kills pids 
 *  @release CARBON 
 *  @vers 1.4 Be Beryllium [asl ]                                           
 *  @date 07/13/2023 08:36:17 
 *  @cdate 07/13/2023 08:36:17 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 
 * 
 */ 
//-----------------<v_&_v>------------------------//

Str Use_= " Demo  of interactively kills pids ";


#include "debug" 
  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

   allowErrors(-1); 

  chkIn(_dblevel)

  chkT(1);



// interactively kill named programs





zapp= _clarg[1];

allowErrors(-1)

<<"zapping $zapp \n"

yn = "y"

int match[4];
int smatch[4];

  svar A;
  
!!"ps -auwx > pslist"

  A=readFile("pslist")

 nl = Caz(A);

<<"$nl processes\n"

//<<"%(1,,,\n)$A\n"

int pid = -1

mypid=getAslPid()

  <<"%V $mypid $_clarg[1]  <|$_clarg[2]|> \n"

  nl = Caz(A);

<<"ps $nl lines - which are $zapp ? \n"
  //<<"$A[0] $A[1]\n"
  //<<"%(,,\n,,)$A[0:5] \n"

  Str pat;
  match = 0;

  for (i = 0; i < nl ; i++) {

    C=Split(A[i]);
    lsz = Caz(C);
//   <<"%(1, , , ,\n) $C \n"
 //  <<" ${C[10]} \n"   

    pat=spat(C[10],zapp,0,1,match);
	if (pat != "") {    
<<"$i  <|$pat|>  $match \n"
        }
/*
    smatch = 0;
 //     <<" $lsz ${C[5]} \n"
      if ( ! (C[10] == "")) {
	//      <<" ${C[*]} \n"
        pat = spat(C[5],zapp,1,1,smatch);
	if (pat != "") {
<<"$i  %V <|$pat|>  $smatch \n"
       }
      }
*/

 if(match[0] ==1 ) {
    pid = atoi(C[1]);
    if (pid != mypid) {
      <<" found process $zapp $pid $C[1] id $C[0] $C[10]\n";
      <<"$C \n";

      // yn=ttyin(" Kill [n/y]?");

      yn=iread(" Kill $pid [n/y]?");

       if (yn @= "y") { // line has \n ?
    <<"Killing $pid \n";
         !!"kill -9 $pid ";
         !!"rm pslist" ;
       }
   }
 }
}



///
  chkOut();
  exit();
;///--------(^-^)--------///

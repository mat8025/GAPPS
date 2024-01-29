//
///
///
#include "debug"

if (_dblevel >0) {
   debugON()
   
}

allowErrors(-1) ; // keep going



 // get  a word

 word = _clarg[1]


  ans = ptan("ag")

<<"$ans \n"

  ans2 = ptan("ah")

<<"$ans $ans2 \n"

//ans=ask(" $ans $__LINE__  ynq [y]\n",1);




 // is it in 'B,C,F,H,I,K,O,N,P,S,V,Y'
 Str sele = "BCFHIKONPSVY";
len = slen(word)

<<"$len $word \n"
allowDB("spe,array")
 Svar Paths[10];


 Paths[2].cpy("hey",3)

<<" Paths \n"



 exit(-1);
int path_n = 1;
 Str e2;
for (i=0;i<len; i++) {
 e= word[i];
 cin = 0;
 c2in = 0;
 if (i+1 <len) {
  e2= word[i:i+1]
 }
 else {
  e2="";
 }
 
 // is it in 'B,C,F,H,I,K,O,N,P,S,V,Y'
//  cin = issin(sele,supper(e))
  cin = issin(sele,e,1)
  c2in = ptan(e2)
  
  <<"%V $i $e $e2 $cin $c2in \n"
ans=ask("%V $e $e2 $__LINE__  ynq [y]\n",1);

 if (cin) {
  <<"$i $e $cin \n"
  Paths.cat("$i,$e,",path_n)
  // TBF Paths[3].cat("$i,$e,")  // should also work

   <<"$Paths[path_n] \n"

  }

 if (c2in) {
  <<"$i $e2 $c2in \n"
  Paths.cat("$i,$e2,",path_n+1)
  // TBF Paths[3].cat("$i,$e,")  // should also work
  
   <<"$Paths[path_n+1] \n"
  }


}


 <<"%V$Paths \n"
 <<"%V$Paths[0] \n"
 <<"%V$Paths[1] \n"
 <<"%V$Paths[2] \n" 
 e.pinfo()


/*

char cv[10]
scpy(cv,word)
char ec
for (i=0;i<len; i++) {
 ec= cv[i];
 <<"$i %c $ec\n"
}
*/
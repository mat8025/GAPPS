/* 
 *  @script can_u_spell.asl 
 * 
 *  @comment can this word be spelled using PT? 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 5.79 : B Au]                                   
 *  @date 01/29/2024 15:34:04 
 *  @cdate 1/28/24 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2024
 * 
 */ 
//-----------------<V_&_V>------------------------//

Str Use_= " Demo  of can this word be spelled using PT? ";

#define _CPP_ 0


#include "debug" 

  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

   allowErrors(-1); // set number of errors allowed -1 keep going 

  chkIn(_dblevel) ;

  chkT(1);

 


// goes after procs
#if _CPP_
int main( int argc, char *argv[] ) { // main start 
#endif       
///
///
///



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
 
 Svar Paths;



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

// how many paths 
 
 // is it in 'B,C,F,H,I,K,O,N,P,S,V,Y'
//  cin = issin(sele,supper(e))
  cin = issin(sele,e,1)
  c2in = ptan(e2)
  
  <<"%V $i $e $e2 $cin $c2in \n"
//ans=ask("%V $e $e2 $__LINE__  ynq [y]\n",1);

 if (cin) {
  <<"$i $e $cin \n"
  Paths[path_n].cat("$e,$i+1,")
  // TBF Paths[3].cat("$i,$e,")  // should also work

   <<"$Paths[path_n] \n"

  }

 if (c2in) {
  <<"$i $e2 $c2in \n"
  Paths[path_n+1].cat("$e2,$i+1")

  
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

#if _CPP_           
  exit(-1); 
  }  /// end of C++ main 
#endif     


///

 chkOut();

  exit();

//==============\_(^-^)_/==================//

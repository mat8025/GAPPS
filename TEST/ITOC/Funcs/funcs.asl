/* 
 *  @script funcs.asl 
 * 
 *  @comment show all asl funcs 
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.17 : C Cl]                                  
 *  @date 05/27/2024 18:25:04 
 *  @cdate 05/27/2024 18:25:04 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2024
 * 
 */ 
//-----------------<V_&_V>------------------------//

Str Use_= " Demo  of show all asl funcs ";

#define _CPP_ 0

#define _ASL_ 1


#include "debug" 

  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

 db_ask =1
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

// check is a known func
  allowDB("spil,spe,rdp,parse,svar,str",1)
 S=functions();
 Nfun = Caz(S)
 
 S.sort();

ans=ask(" $Nfun OK",1)


A=ofw("funcs_list.csv")
<<[A]"%(1,,,\n)$S\n"
cf(A);

A=ofr("funcs_list.csv")
if (A != -1) {
S=readfile(A);
sz= Caz(S)

 Svar C;

<<"fname,table_id, libname,info,test,desc\n"
 for (i= 0; i < 10; i++) {

 C= Split(S[i],',');
 foo = C[0];
// <<"%V $foo\n"
 index = findfunc(foo)
 
// <<"$foo, $index, $C[1] ,Y, N, '${C[2::]}', \n"
 <<"$foo, $index, $C[1]   \n"
ans=ask(" $i $foo",0)
}

}


#if _CPP_           
  exit(-1); 
  }  /// end of C++ main 
#endif     


///

 chkOut();

  exit();

//==============\_(^-^)_/==================//

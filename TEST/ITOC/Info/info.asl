/* 
 *  @script info.asl 
 * 
 *  @comment info for a variable -- x.pinfo()  
 *  @release 6.23 : C V 
 *  @vers 1.2 He Helium [asl 6.23 : C V]                                    
 *  @date 06/07/2024 13:07:43 
 *  @cdate 06/07/2024 13:07:43 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2024
 * 
 */ 
//-----------------<V_&_V>------------------------//

Str Use_= " Demo  of info for a variable -- x.pinfo()  ";

#define _CPP_ 0

#define _ASL_ 1


#include "debug" 

  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

   allowErrors(-1); // set number of errors allowed -1 keep going 

  chkIn(_dblevel) ;

  chkT(1);


// CPP main statment goes after all procs
#if _CPP_
   int main( int argc, char *argv[] ) { // main start 
#endif       

///
///
///


  
 
  
  void goo()
  {
  
  short c = 3;
  
  c.pinfo()
  
  ci = c->info()
  
  
  <<"%V $c  $ci\n"
  chkN(c,3)
  
  }
  
  int ok =0;
  int a = 1;
  
  sa= a.pinfo(1)


  ans=ask("pinfo returns <|$sa|>",0)

 ok = a.checkinfo("INT"); // check for this str in the info

  if (ok) {
<<" $a is an INT\n"

  }

  ok = a.checkinfo("FLOAT");

  if (ok) {
<<" $a is an FLOAT\n"

  }

  ans=ask("checkinfo ?",0)

  ai = a.pinfo(1)
  
  
  <<"%V $a  $ai\n"

ans=ask("pinfo returns <|$ai|>",0)


   chkN(1,a)
  
  float b = 2;
  
  b.pinfo()
  
  bi = b.info()
  
  
  <<"%V $b  $bi\n"
  chkN(b,2)
  
  goo()
  
  
  IV = vgen(INT_,10,0,1)
  
  IV.pinfo()
  
  k = IV[3]
  IV[4] = 67;

  chkN(k,3)

  SOF=IV.pinfo()
  <<"SOF:: $SOF\n"
  
  offs = IV.offsets()
  
  <<"%V $offs \n"


chkN(offs[2],4)

  
  IVi = IV.info()
  
  <<"$IVi \n"
  vid = IV.varid()
  <<"%V $vid \n"
  obid = IV.objid()
  <<"%V $obid \n"
  chkN(obid,-1)
  


#if _CPP_           
  exit(-1); 
  }  // end of C++ main 
#endif     


///

  chkOut(1);

  exit();

//==============\_(^-^)_/==================//

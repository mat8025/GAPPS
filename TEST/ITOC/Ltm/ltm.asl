/* 
 *  @script ltm.asl 
 * 
 *  @comment Demo LTM read,write,check - never forget 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 5.81 : B Tl]                                   
 *  @date 02/04/2024 07:38:40 
 *  @cdate 1/1/2010 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2024
 * 
 */ 
//-----------------<V_&_V>------------------------//

Str Use_= " Demo  of Demo LTM read,write,check - never forget ";

#define _CPP_ 0

#define _ASL_ 1


#include "debug" 

  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

   allowErrors(-1); // set number of errors allowed -1 keep going 

  chkIn() ;

  chkT(1);

 


// goes after procs
#if _CPP_
int main( int argc, char *argv[] ) { // main start 
#endif       



///
///  LtmWrt (tag, value)
///
//wdb=DBaction(DBSTEP_,ON_)


 where =showEnv()
 <<"$where \n"
<<" it's on the tip of my tongue \n"




  ok=ltmWrt("tot","maybe not",1);
  
<<" %V $ok\n"
  ok=ltmWrt("mtot","maybe not",1);
  if (ok > 0) {
     val = ltmRead("tot")

<<"updated tot   $val\n"

  }

  ok =ltmWrt("focus","on tasks",1);
<<" %V $ok\n"


  ok =ltmWrt("ltm","corrupted",1);
<<" ltm %V $ok\n"

  val = ltmRead("tot")

<<"tot   <|$val|> \n"

   chkStr(val,"maybe not")

ans=ask(DB_prompt,0)

  val = ltmRead("focus")

<<"focus  $val\n"


 ok= ltmWrt("str 2"," 47 79",1);
<<" %V $ok\n"
 ok= ltmWrt("str 3"," '19,74,13'",1);
<<" %V $ok\n"

ok= ltmWrt("mytasks"," these are never ending and I must persevere",1);
<<" %V $ok\n"

val = ltmRead("str 1")

<<"str 1  <|$val|> \n"

val = ltmRead("str 2")

<<"str 2  <|$val|> \n"


val = ltmRead("str 3")

<<"str 3  <|$val|> \n"

 i= ltmCheck("tot")

<<"tot $i \n"


 i= ltmCheck("strange")

<<"strange $i \n"

 ok=ltmWrt("tot","most certainly will",1)
 <<" %V $ok\n"
  if (ok) {
<<"update tot\n"
  }

  val = ltmRead("tot")

<<"tot   $val\n"

 ok=ltmWrt("tot","just not quite there")
 
  if (ok > 0) {
<<"updated tot\n"
  }

  val = ltmRead("tot")

<<"tot   $val\n"


  val = ltmRead("mytasks")

<<"mytasks   $val\n"

ok=ltmWrt("reasons","what why",1)

 val = ltmRead("reasons")

<<"reasons are   $val\n"

   chkOut(1);

#if _CPP_           
  exit(-1); 
  }  /// end of C++ main 
#endif     


///




//==============\_(^-^)_/==================//

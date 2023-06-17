/* 
 *  @script tpclass.asl 
 * 
 *  @comment turnpt class for showtask 
 *  @release CARBON 
 *  @vers 1.5 B 6.3.83 C-Li-Bi 
 *  @date 02/15/2022 17:26:49          
 *  @cdate 1/1/2001 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                                                                                                                                 


#define ASL 1
//<<" TPCLASS\n"

int Tleg_id = 0;
#if ASL

//<<"GT_DB $(GT_DB) \n"

if (GT_DB) {
<<"%V $_include $Tleg_id\n"
}

#endif

class Tleg 
 {

 public:

  
  int tpA;
  int tpB;
  
  float dist;
  float pc;
  float tfga;
  float msl;

  Str Tow;
  Str Tplace;

//  use cmf for cons,destruct PP will remove in asc version 
 cmf Tleg()   
 {
 //<<"Starting cons \n"
  dist = 0.0;
  pc = 0.0;
  tfga =0;
  msl = 0.0;
 // <<"Done cons $dist $pc\n"
 }
 
 Str getPlace ()   
   {
       return Tplace; 
   }
 cmf   ~TLeg()
    {
          <<"destructing Tleg \n";
    }

};   // need ;


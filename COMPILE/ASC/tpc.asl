
///
///
///


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

//  use cmf for cons,destruct
//  preprocess to asc will remove cmf
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


//
//
//
#define GT_DB 1
 
#define ASL 0
//
#define TPCLASS_ 1

int Tleg_id = 1;
 


#if ASL

//<<"GT_DB $(GT_DB) \n"

 if (GT_DB) {
<<"%V $_include $Tleg_id\n"
}
#endif


if (Tleg_id == 1) {

<<"%V $Tleg_id \n"

}


class Tleg 
{

 public:

  
  int tpA;
  int tpB;
  
  float dist
  float pc

 cmf Tleg()  
 {
 //<<"Starting cons \n"
  dist = 0.0;
  pc = 0.0;

 // <<"Done cons $dist $pc\n"
 }

 };

#endif


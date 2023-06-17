///
///
///
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
//----------------<v_&_v>-------------------------//



//#include "debug"
//  debugON();

ignoreErrors();

 filterFileDebug(REJECT_,"pr_state.cpp","declare_e.cpp","scopesindex_e.cpp","scope_e");

 filterFuncDebug(REJECT_,"checkScopeSiv","si_declare_type", "checkExpression","writeASC");



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


 Str GetPlace ()   
   {
       return Tplace; 
   }


//  use cons,destroy   -- have then set to NULL in CPP header
  Tleg()
  {
 
  <<"Starting cons \n"
  
  dist = 0.1;
  pc = 0.0;
  tfga = 0;
  msl = 5280.0;
  Tplace = "Boulder";
 <<"Done cons $dist $pc $msl\n"

  }
 
  ~Tleg()
    {
          <<"destructing Tleg \n";
    }


};   // need 

int Ntp_id = 0; // ids for turnpt objs

class Turnpt 
 {

 public:
 //static uint Ntp_id;
  Str Lat;
  Str Lon;
  Str Place;
  
  Str Idnt;
  Str rway;
  Str tptype;
  
  Str Cltpt;
  Str Radio;
  float Alt;
  float fga;  // final glide msl to next TP?
  float Ladeg;
  float Longdeg;
  int is_airport;
  int is_strip;
  int is_mtn;
  int is_mtn_pass;
  
  int id;
  //int match[2];
  int match;
  Str smat; 
  
//  int amat;

//  method list

// for cpp  either use reference or ptr
// else copy constructor - memory corruption??

//=========================//

 void TPCUPset (Svar& wval)
 {

//<<"IN $_proc \n"
Str val;

Str val2;

      wval.pinfo();
      val.pinfo();
 //  <<"%V $Alt\n";

//<<"cmf %V $_scope $_cmfnest $_proc $_pnest\n"
 //  pa(wval);
//  aslpinfo(wval);
//<<" $wval \n"

//<<"TP  $wval[0] \n"

     val = wval[0];
     
//<<"%V $val\n"


//cout << "val " << val << endl;
//pa(wval); // crash ??


//      val.aslpinfo();

      val.dewhite(); // TBF ? corrupting vars ?

//<<"%V $AFH\n"

    val.scut(1);
//cout << "val " << val << endl;

//<<"post-scut 1 $val\n"

     val.scut(-1);

//<<"post-scut -1  $val\n"

//cout << "val " << val << endl;
     Place = val; // wayp 

//<<"%V $place \n";



//cout << "Place " << Place << endl;

     val =  wval[1];

    val.scut(1);
     
     val.scut(-1);

     Idnt = val;
//<<"%V $AFH\n"

//  <<"%V$Idnt\n"
//Idnt->info(1)

     Lat = wval[3]; // wayp
     
//cout << "Lat " << Lat <<endl;
//<<"%V $Lat \n"
     ccoor(Lat);
//<<"%V $Lat \n"     
 
     Lon = wval[4];

     ccoor(Lon);

 //<<"%V$Lon  \n"
  
     val = wval[5];

    // pa(val);
    // ft or m

//ans=query("?","sele",__LINE__);
    val2 = sele(val,-1,-2);

//<<"%V $val2\n"
    if (val2 == "ft") {

      val.scut(-2); 
//<<"ft  $val\n";
      Alt = atof(val);
   }
    else {
       val.scut(-1);
//<<"m $val\n";       
            Alt = atof(val);
	    Alt *= 3.280839 ;

    }
 //<<"%V$val $val2 $Alt  \n"




     is_airport =0;
     is_mtn =0;
     is_mtn_pass =0;     
     is_strip = 0;
     rway = wval[6];



     if (rway == "5") {
         is_airport =1;
     }

     if (rway == "3") {
         is_strip =1;
     }

     if (rway == "7") {
         is_mtn =1;
     }

     if (rway == "8") {
         is_mtn_pass =1;
     }

     rway = wval[7];

     if (rway != "") {
       //  is_airport =1;
     }

    val = wval[9];


     //Radio = atof(wval[9]);

     Radio = wval[9];

     if (Radio == "") {
          Radio = "    -    ";
     } 

     tptype = wval[10];
     
     Ladeg =  coorToDeg(Lat,2); 

     Longdeg = coorToDeg(Lon,2);

      }
//=========================//

//void SetPlace (Str val) 05/02/23 - fix preprocess arg 
//  preprocess not releasing proc arg - error var arlready declared! 
void SetPlace (Str pval)   
   {
      pval.pinfo()
       Place = pval;
       splace = pval; // bug no indent
       splace.pinfo();
      // val2.pinfo(); // CMF should produce non-fatal error FIX
       val3.pinfo();   // CMF should produce non-fatal error FIX
       pval.info();
       
   }
//=========================//
void SetRadio (Str pval)   
   {
       pval.pinfo()
       pval3= pval;
       Radio = pval;
       Radio.pinfo();   // CMF should produce non-fatal error FIX
       
   }
//=========================//
void SetAlt (float pval)   
   {
       pval.pinfo()

       Alt = pval;
       Alt.pinfo();   // CMF should produce non-fatal error FIX
       
   }
//=========================//

  Str GetPlace ()   
   {
    splace = Place; 
       return splace; 
   }
//=========================//
   void Print ()    
   {
     //<<"$Place $Idnt $Lat $Lon $Alt $rway $Radio $Ladeg $Longdeg\n"

     <<" $Place   $Radio  $Alt\n"

   }
//=========================//


 int GetTA()   
   {
      int amat[2];
      spat (tptype,"A",-1,-1,amat);
    //  pa("amat ",amat);
      return amat[0];
   }
//=========================//

cmf  Turnpt()
 {


//id = Ntp_id++;

            Ntp_id++;

      id = Ntp_id;
      Place=" ";
      Ladeg = 0.0;
      Longdeg = 0.0;
      Alt = -1.5;
    //<<"CONS $id $Ntp_id\n"
   }
//=========================//

};

 float ComputeTC(Turnpt wtp,int j, int k)
  {

  //<<"$_proc %V $j $k\n";
<<" %V $j $k \n"


   wtp.pinfo();


  float km = 0.0;
  float tc = 0.0;
 // float L1,L2,lo1,lo2; // preprocess bug
  float L1
  float L2
  float lo1
  float lo2;

  
  L1 = wtp[j].Ladeg;

  L2 = wtp[k].Ladeg;

  <<"%V $L1 $L2 \n";

  lo1 = wtp[j].Longdeg;

  lo2 = wtp[k].Longdeg;

<<"%V $lo1 $lo2 \n";

//  tc = TrueCourse(L1,lo1,L2,lo2);

  tc = TrueCourse(lo1,L1,lo2,L2);

  //printargs(j, k ,L1 ,lo2 ,"tc=", tc);

 <<"%V $tc\n"


  return tc;

  }
  
//===========================//

  setDebug(1,"step","trace","pdb",0)

<<" Stepping? \n"

  Svar Wval;

 <<" defined Tleg class - what now \n";




 Str rad = "122.72";
 Tleg  T;

 T.pinfo();


 //val.pinfo();  // MAIN should produce non-fatal error

 //val2.pinfo();

// wp = T.GetPlace();
  wp = T.GetPlace();

<<"%V $wp \n";





Turnpt A




 A.pinfo()

  A.SetRadio(rad)

 A.SetPlace("Boulder")  // bug no semicolon produced
 
 wp = A.GetPlace() // bug no Str auto type   - needs to find GetPlace method and set to Str

<<"%V $wp \n";  // bug wrong type for cprintf

 mhi = 5280.0;
 
 A.SetAlt(mhi);

 A.Print()



 Turnpt  GT_Wtp[50]

//pval.info();
int AFH;  // ofr - not return as int but Siv?
// preprocessor should not try to call ofr

  AFH=ofr("bbrief.cup")  ; // open turnpoint file;

  printf( "opened CUP/bbrief.cup AFH %d \n",AFH);


Str the_start = "longmont";

Str the_finish = "boulder";


  i=searchFile(AFH,the_start,0,1,0,0);
  seekLine(AFH,CURRENTLINE_)
<<" %V $the_start $i\n"
  nwr = Wval.readWords(AFH,0,',');
<<"$nwr  $Wval \n"


<<"  $Wval[1] \n"
<<"   $Wval[3] \n"




GT_Wtp[1].TPCUPset(Wval);

  i=searchFile(AFH,the_finish,0,1,0,0); // auto dec - has to look up searchFile to find it returns long
  
  seekLine(AFH,CURRENTLINE_)
<<" %V $the_finish $i\n"



 nwr = Wval.readWords(AFH,0,',');
<<"$nwr  $Wval \n"
<<"  $Wval[1]  :  $Wval[3] \n"
GT_Wtp[2].TPCUPset(Wval);



 tc = ComputeTC(GT_Wtp,1, 2) ; // preprocessing causes crash
 
  <<" %V $tc \n"



chkOut();


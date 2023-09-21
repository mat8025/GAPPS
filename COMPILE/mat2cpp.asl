/* 
 *  @script mat2cpp.asl  
 * 
 *  @comment test cpp compile include and sfunc 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.73 C-Li-Ta]                                
 *  @date 01/16/2022 10:43:41 
 *  @cdate 01/16/2022 10:43:41 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
//-----------------<v_&_v>------------------------//

///
///
///
#define _CPP_ 0
#if _CPP_
#include "cpp_head.h" 
	Str myvers = MYFILE;
#endif

#if _ASL_
#include "hv.asl"
myvers =Hdr_vers
#define cout //
#define COUT //
#define CDB ans=query("go on");
//#define CDBP (x) ans=query(x,"go on"); // asl not working
#define AST matans=query("?","ASL DB go_on?",__LINE__,__FILE__);
<<"ASL   $(_ASL_) CPP $(_CPP_)\n"
printf("_ASL_ %d _CPP_ %d\n", _ASL_,_CPP_);
#define CDBP //
#endif



#if _CPP_
#warning USING_CPP
#define CDBP(x) ans=query(x,"go on",__LINE__,__FILE__);
#define CDB ans=query("?","go on",__LINE__,__FILE__);
#define  CHKNISEQ(x,y)  chkN(x,y,EQU_, __LINE__);
#endif


int showMat(Mat T)
{
   double val ;

#if _CPP_
   val = T.eleAsD(1,1);
#else
   val = M[1][1]
#endif
   printf("showMat: val (1,1) %f\n",val);
   COUT(T);


}

//////////////////////////  CPP MAIN /////////////////////
#if _CPP_

int main( int argc, char *argv[] ) { 
        cpp_init();
        init_debug ("mat.dbg", 1, "1.2");
        cprintf("%s\n",MYFILE);

#endif               




  Siv MS(INT_)

  MS=14

  COUT(MS)






double rms;
double val;
double dval;

  int D[20];

   D.pinfo();
//ans=query("?","Vec D(20) ",__LINE__);

   Mat M(DOUBLE_,5,4);


int index = 6;

   COUT(index)

   COUT(M);
   
   dval = 76.67;
   
   M = dval;  // the whole array is set 

  // M[2][3] = 47;

#if _CPP_
   val = M.eleAsD(1,1);
#else
   // trans ==>     = M.eleAsD(1,1);
   // or trans ==>  =  *(typeof(M) *) M(1,1)
   val = M[1][1]
#endif

  <<"%V $val\n"

   chkF(val,dval);
   
#if _CPP_
   M(1L,2L) = 77.88; // ele set at row 1 col 2
#else
   M[1][2] = 77.88
#endif



   COUT(M);


#if _CPP_
   val = M.eleAsD(1,2);
#else
   val = M[1][2]
#endif

    <<"%V $val\n"

   chkF(val,77.88);


#if _CPP_
   M( rows(0,3,1), cols(1,3,2))  = 23.34;   // range setting  bes
#else
   M[0:3:1][1:3:2] = 23.34
#endif

  M.pinfo()

  COUT(M);

    int rvec[3] = {1,4,1};
    int cvec[3] = {0,4,-1};

<<"cevc  rvec \n"
    cvec.pinfo()
    
    rvec.pinfo()
    
#if _CPP_
   M(rvec, cvec)  = 17.71;   // range setting  bes
#else
     M[rvec][cvec]  = 17.71;   // range setting  bes
#endif

   ans = "M($rvec , $cvec)";

<<"$ans\n"
   M.pinfo()
 
 //M( (const int[]) {0,5,1}, (const int[]) {1,3,1})  = 46.64;

//COUT(M);
 


#if _CPP_
  val = M.eleAsD(2,3);
#else
  val = M[2][3]
#endif





 printf("val %f\n",val);

  showMat(M);  // TBF not happening!





 Siv SV(INT_,1,10,-3,1);
 
 SV.pinfo();

  index = SV[2];



 short jj = 9;


 printf("[j] LH access \n");


//
 // can't do an exact cpp operator version
//  can do G(0,-1,2) for cpp
//  but then require revise for asl - or translate/prep program
//  can use vmf,cpp functions
//  

// for Matrix
// instead of M[0:3:1][0:-1:1]
// use trans option asl -wT  to get
//  M(rng(0,3,1), rng(0,1,1))
//  or  M (br,er,sr, bc,ec,sc)

//  3,4,5 D
// has to be vargs 

   chkOut(1);


  dbt("Exit cpp testing Mat \n");



#if _CPP_              
  //////////////////////////////////
  cprintf("Exit CPP \n");
  exit(0);
 }  /// end of C++ main   
#endif               





//==============================//







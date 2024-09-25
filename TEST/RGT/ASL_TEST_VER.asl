/* 
 *  @script ASL_TEST_VER.asl                                            
 * 
 *  @comment asl test modules                                           
 *  @release Carbon                                                     
 *  @vers 1.65 Tb Terbium [asl 6.30 : C Zn]                             
 *  @date 07/16/2024 19:16:25                                           
 *  @cdate 1/1/2005                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 

//----------------<v_&_v>-------------------------//;                  


//
// test asl first and second stage (xic)
//

Str ans;
/*
#include "debug.asl"


if (_dblevel > 0) {
   debugON()
}
*/

#include "hv.asl"

_DBH = -1

int inflsz = 0;
int outflsz = 0;
int Report_pass = 1;

setmaxcodeerrors(-1); // just keep going
setmaxicerrors(-1);
 ignoreErrors()
 allowErrors(-1)
 
#define PGREEN '\033[1;32m'
#define PRED '\033[1;31m'
#define PBLUE '\033[1;34m'
#define PYELLOW '\033[1;33m'
#define PPURPLE '\033[1;45m'
#define PBLACK '\033[1;39m'
#define POFF  '\033[0m'


//wasl = "aslx"   // alsx should be stable

wasl = "asl"
Str Test_suite ="XYZ"

//<<"using $wasl for testing \n"

!!"asl -v"

!!"mkdir -p Scores"

ans= ask("scores OK",0)

//str Progname = "abcd";
//str Dirname = "Fact"
//ws= getenv("GS_SYS")

!!"rm -f ../*/*.tst"
!!"rm -f ../*/*.xtst"
!!"rm -f ../*/*.out"
!!"rm -f ../*/*.xout"

// do not remove our own debug

//!!"rm -f ../*/*.idb"
//!!"rm -f ../*/*.xdb"

hdir = getdir();

wd= chdir(hdir)
wdir = getdIr()
<<[_DBH]"%V $wd $hdir $wdir\n"

wasl = "aslx"
//ans=query("where are we")


//str S = "all,array,matrix,bugs,bops,vops,sops,fops,class, declare,include,exp,if,logic,for,do,paraex,proc,switch,try"
//S.cat("types,func,command,lhsubsc,dynv,mops,scope,oo,sfunc,svar,record,ivar,lists,stat,threads,while,pan,unary,ptrs,help");

str S = "all array bops bugs class command declare do dynv exp fops "
S.cat("for func help if include ivar lhsubsc lists logic")
S.cat("matrix mops oo pan paraex proc ptrs record redimn resize ")
S.cat ("scope sfunc sops stat svar switch threads try types unary vops while");


Svar Opts[] = Split(S);


<<[_DBH]"%V $Opts \n"





 


//<<"$Testdir\n"
TM= FineTime();

today=getDate(1);
<<"$today $(get_version())\n"

chdir(hdir)
cwd=getdir()

//Opf=ofw("Scores/score_$(date(2,'-'))")

Opf=ofw("current_score")


Tcf=ofw("test_crashes")
Tff=ofw("test_fails")

Tlogf=ofile("test.log","ar+")


Dbf=ofw("test_debug")


<<[Opf]"$today $(get_version())\n"

do_pause = 0;
do_error_pause = 0

do_xic = 1;   // option?

int n_modules = 0
int rt_tests = 0
int rt_pass = 0
int rt_fail = 0
int rtx_fail = 0
int rt_crash = 0
int i_time = 0;
int x_time = 0;

str rt_script = "xy"

Todo=ofw("to_test")

#include "test_routines"


tout ="testoutput"
ictout ="ictestoutput"

//!!"echo ictest > $tout"
//!!"echo ictest > $ictout"

//cart("bops","78")
//chkT(0)

CFLAGS = "-Rcwlu"

//CFLAGS = "-cwlm"     // m to mask src lines in exe file --- broke

ntest = 0


 
int do_all = 1;
int do_level2 = 0;
int do_query = 0;
int do_help = 0;
int do_module = 0;
int do_dev = 0;





int do_array = 0;
int do_matrix = 0;
int do_math = 0;

int do_bugs = -1;
int do_bops = 0;
int do_vops = 0;
int do_sops = 0;
int do_fops = 0;
int do_class = 0;


int do_declare = 0;
int do_define = 0;
int do_recurse = 0;

int do_syntax = 0;
int do_basic = 0;
int do_include = 0;
int do_if = 0;
int do_enum = 0;
int do_bit = 0;
int do_logic = 0;
int do_for = 0;
int do_do = 0;
int do_proc = 0;
int do_switch = 0;
int do_scope = 0;;
int do_while = 0;
int do_try = 0;
int do_exp = 0;
int do_paraex = 0;
int do_types = 0;
int do_func = 0;
int do_iproc = 0;
int do_command = 0;
int do_lhsubsc = 0;
int do_dynv = 0;
int do_mops = 0;
int do_oo = 0;
int do_sfunc = 0;
int do_svar = 0;
int do_record = 0;
int do_ivar = 0;
int do_lists = 0;
int do_resize = 0;
int do_redimn = 0;
int do_stat = 0;
int do_threads = 0;
int do_pan = 0;
int do_unary = 0;
int do_ptrs = 0;
int do_vmf = 0;
int do_tests = 0;





  pdir=updir()
  chdir("ITOC")
  Testdir = getdir()
  
<<[_DBH]"Test Dir is $Testdir\n"


List CrashList(STRV_);

// CrashList = ( ""  )  // empty list
// CrashList.Delete(0) ; // make empty



//   FailList = ( ""  )  // empty list --- bug first item null? 

  List FailList(STRV_);

 



  nargs = ArgC()

<<[_DBH]"%V$nargs\n"



  if (nargs > 1) {
    do_all = 0
   //<<[2]" selecting tests \n"
  }

<<[_DBH]"%V $do_all \n"

  i = 1;



    while (1) {


      wt = _argv[i]



   // wt.pinfo()

<<[_DBH]"what's this arg $i <|$wt|> \n"

    if (wt == "") {
      break
    }

      if (wt == "-fix") {
        Report_pass = 0  
     }
    
    
   //  if (wt == "bops") {
  //      do_bops = 1
  //	<<" %V $do_bops \n"
  //   }
   
      do_arg = "do_$wt"

<<[_DBH]"arg $i  $_argv[i] <|$wt|> <|$do_arg|> \n"
//ans=ask("arg $i  $_argv[i] <|$wt|> <|$do_arg|>",1)

     if (scmp(wt,"~",1) ){
        wt=scut (wt,1);
	<<"don't run $wt\n"
	do_arg = "do_$wt"
	$do_arg = -1;
      }
      else {
      
      $do_arg = 1;

      }
     
 <<[_DBH]" $i $wt $do_arg \n"

     i++;
    // TBF {} needed
    if (i >= nargs) {
          break;     
    }
  }


  if (do_help) {

      Help();
      exit();
  }

<<[_DBH]"%V $do_all $do_bops $do_mops $do_query \n"

//ask("DONE ARGS %V $wasl  $do_query $do_bops",0)

//================



if (do_dev) {
  wasl = "aslx"
  <<"testing  DEVELOPMENT version aslx \n"
}
else {
  <<"testing lastest RELEASE version asl\n"
// could look at gasp-RELEASE dir to find latest 
// or could link /home/mark/gasp-RELEASE/gasp-CARBON
// to older specific release gasp-CARBON-6.xx

}

  !!"$wasl -v"

if (do_level2) {
    do_bops =1;
    do_syntax =1;
    do_types =1;    
}

if (do_basic ==1) {
 do_if = 1;
 do_logic = 1;
 do_for = 1;
 do_do = 1;
 do_switch = 1;
 do_while = 1;
 do_scope = 1;  
 do_include = 1;
 do_try = 1;
 do_bops =1;
}


if (do_syntax ==1) {
 do_if = 1;
 do_logic = 1;
 do_for = 1;
 do_do = 1;
 do_switch = 1;
 do_while = 1;
 do_scope = 1;  
 do_include = 1;
 do_try = 1;  
}

if (do_syntax == -1) {

 do_if = -1;
 do_logic = -1;
 do_for = -1;
 do_do = -1;
 do_switch = -1;
 do_while = -1;
 do_try = 1;
 do_scope = -1;
 do_include = -1;  

}

if (do_math) {
    do_mops = 1;
}


//<<" check Include $do_include $do_types\n"

allowDB("spil,pex,ds,ic",1);



if ((do_include || do_all ) && (do_include != -1)) {

  Run2Test("Include")

  cart("include")

  //RunDirTests("Include","include")
  outcome("INCLUDE")
}

//================================//

  if ((do_bops || do_all) && (do_bops != -1)) {

    inflsz = caz(FailList)

//<<"bops,fvmeq,fsc1,mainvar,snew,parse_exp\n";

    RunDirTests("Bops","bops,fvmeq,fsc1,mainvar,snew,parse_exp");

  RunDirTests("Assign","assign");

  RunDirTests("Info","info");

  // RunDirTests("Assign","assign");

    Run2Test("Bops")


// !!!! if basics fail warn/ask before going on to rest of testsuite
  rt_script = "bops"
  rt_arg1 = "7"
  rt_arg2 = "9"
  
  cart(rt_script,rt_arg1)

  cart_xic(rt_script,rt_arg1)
  
  rt_script = "fvmeq"
  //cart(rt_script,rt_arg2)

  //cart_xic(rt_script,rt_arg2)
  
  updir()

  chdir ("Contin")
  //changeDir("Contin")

  cart("contin")

  updir()

  chdir("Mod")

  cart("mod")

 // updir()


  //chdir("Info")

//  do_carts("info")





    outcome("BOPS")
   }

////////////// OO ///////////////////////


   if ((do_all || do_class )  && (do_class != -1)) {
    inflsz = caz(FailList)
        RunDirTests("Class","classbops,classmfcall,class2,classvar");
       outcome("CLASS")
    }



   if ((do_all || do_oo ) && (do_oo != -1)) {
    inflsz = caz(FailList)

    //RunDirTests("OO","oa2,rpS,rp2,wintersect,oa,classarray,simpleclass");
    RunDirTests("OO","oa,rpS,rp2,oa2,classarray,simpleclass");

    RunDirTests("Obcopy","obcopy,obprocarg");

    RunDirTests("Mih","sh,mih,sih")

    outcome("OO")
  }


////////////// IF ///////////////////////

if ((do_if || do_all) && (do_if != -1)) {
    inflsz = caz(FailList)
  
    RunDirTests("If","ifand,if,ifelse")



    outcome("IF")


  }
////////////////////////////////////////////////////////////////////////

////////////// Define ///////////////////////

if ((do_define || do_all) && (do_define != -1)) {
      inflsz = caz(FailList)
  RunDirTests("Define","define")


  outcome("DEFINE")
  }
////////////////////////////////////////////////////////////////////////

////////////// Enum ///////////////////////

if ((do_enum || do_all) && (do_enum != -1)) {

    inflsz = caz(FailList)
    RunDirTests("Enum","enum,colors_enum")

    outcome("ENUM")
  }
////////////////////////////////////////////////////////////////////////




if ((do_bit || do_all) && (do_bit != -1)) {
    inflsz = caz(FailList)
//  Run2Test("Bitwise");
//  cart("bitwise");
   RunDirTests("Bitwise","bitwise")
   outcome("BITWISE")
}



  if ((do_logic || do_all) && (do_logic != -1)) {


   inflsz = caz(FailList)
   //<<"%V $inflsz \n"
 //  echolines(1)
   RunDirTests("Logic","logic,logicops,logicdef")
   //RunDirTests("Logic","logic,logicops")

   RunDirTests("Compare","compare")

  outcome("LOGIC")

  }

 if ((do_for || do_all) && (do_for != -1)) {

  inflsz = caz(FailList)

  RunDirTests("For","for,for_exp")
   
  
  outcome("FOR")

}


////////////////////////////////////////////////////////////////////////
 

  if ((do_all || do_while ) && (do_while != -1)) {
        inflsz = caz(FailList);
	
       RunDirTests("While","whilenest,while")
       RunDirTests("Continue","continue");
      outcome("WHILE")
    }
////////////////////////////////////////////////////////////////////////






if ((do_all || do_do ) && (do_do != -1)) {
    inflsz = caz(FailList)
      RunDirTests("Do","do")
      outcome("DO")
    }

if ((do_all || do_try ) && (do_try != -1)) {
    inflsz = caz(FailList)
      RunDirTests("TryThrowCatch","trythrowcatch")
       outcome("TRY")
    }
////////////////////////////////////////////////////////////////////////


//======================================//
    if ((do_switch || do_all) && (do_switch != -1)) {

       inflsz = caz(FailList)
     

       RunDirTests("Switch","switch")

       outcome("SWITCH")
   }

//======================================//

    if ( (do_types || do_all) && (do_types != -1)) {
      inflsz = caz(FailList)
      RunDirTests("Types","types");
      
      RunDirTests("Cast","cast,cast-vec")

      RunDirTests("Efmt","efmt");

      RunDirTests("Swab","swab")
outcome("TYPES")
      //rdb()
  }
//======================================//

  if ((do_vops || do_all ) && (do_vops != -1)) {
    inflsz = caz(FailList)


     RunDirTests("Vops","vops")
outcome("VOPS")
    inflsz = caz(FailList)
     RunDirTests("Vector","vector")
outcome("VECTOR")
     RunDirTests("Reverse","reverse") ; // BUG needs more than one
  }



//////////////////////////////////////////////////

  if ( (do_sops || do_all) && (do_sops != -1)) {
      //  need more str ops tests than this!
    inflsz = caz(FailList)
   RunDirTests("Sops","sops");

 
 
  // RunDirTests("Str","str-proc,str-arg,str-lit");
    inflsz = caz(FailList)
  RunDirTests("Str","str_proc,str_arg");

//outcome("STR")
   //hdg("Strops");
   
   RunDirTests("Strops","strops,scmp_syntax");

 //  hdg("Splice");
   RunDirTests("Splice","splice,strsplice");
 
  // make this a pattern OP

 // RunSFtests("Date,Sele,Sstr,Spat,Str,Split,Regex,Fread,Trunc,Tranf");
   RunSFtests("Scut,Ssub,Scmp,Date,Sele,Sstr,Spat,Split,Regex,Fread,Trunc,Tranf");

   outcome("SOPS")
  }

/////////////////////////////////////////////////

  if ((do_fops || do_all) && (do_fops != -1)) {
    inflsz = caz(FailList)
  RunDirTests("Fops","fops")
  RunDirTests("Fh","fh")  


  // need to do  script arg1 agr2 ...
  RunDirTests("Fexist","fexist")

    outcome("FOPS")




  }
//======================================//

if ((do_all  || do_declare ) && (do_declare != -1))  {

    inflsz = caz(FailList)
    RunDirTests("Declare","declare,decc,decchar,decpan,decvec");
   
    outcome("DECLARE")


 //  Run2Test("Consts")

 //  cart ("consts_test")





/////////////////////////////////////////////////////////////////////////////////

    }


if ((do_all  || do_resize ) && (do_resize != -1))  {

   RunDirTests("Resize","resize")
   outcome("RESIZE")

}


if ((do_all  || do_redimn ) && (do_redimn != -1))  {


   RunDirTests("Redimn","redimn")
   outcome("REDIMN")
}




/////////////////////////////////////////////





chdir(Testdir)

 if ((do_exp || do_all) && (do_exp != -1)) {

    inflsz = caz(FailList)

   RunDirTests("Sexp","sexp");


outcome("EXP")

    }

//rdb()

 if ((do_all || do_paraex ) && (do_paraex != -1)) {
    inflsz = caz(FailList)
  Run2Test("ParaEx")

  cart("paraex")

outcome("PARAEX")


 }


/////////////// ARRAY //////////////////////

if ((do_all || do_array ) && (do_array != -1)) {

  inflsz = caz(FailList)

  RunDirTests("VVcomp","vvcomp");

  RunDirTests("Vfill","vfill");


   RunDirTests("Subrange","subrange");

   RunDirTests("VVcopy","rangecopy,vvcopy")

   RunDirTests("ArraySubSet","arraysubset,arraysubvec,arrayeleincr")

   RunDirTests("ArraySubSet","arraysubsref,arraysubscbyvec,vdec")

   RunDirTests("Array","ae,arraycmp,arrayele")

   RunDirTests("Array","dynarray,lhe,vec_cat,array_sr,mdele,vsp")

   RunDirTests("ArrayRange","arrayrange,arraysubsrange,lhrange")

  

  RunDirTests("ArrayJoin","arrayjoin")

  RunDirTests("Scalarvec","scalarvec")



  RunDirTests("PrePostOp","prepostop");

 // Run2Test("PrePostOp")
//   do_carts("prepostop")

  RunDirTests("M3D","m3d,m3d_assign")

  RunDirTests("Sgen","sgen")

   RunDirTests("VVgen","vvgen")

  RunDirTests("Vgen","vgen,vgen_pan")

  outcome("ARRAY")


    }


/////////////////////////////////////////

 if ((do_all || do_matrix ) && (do_matrix != -1)) {
     inflsz = caz(FailList)
   RunDirTests("Mdimn","mdimn")


   RunDirTests("Matrix","mat_mul,mat_inv,mat_sum,msquare,mdiag");
   

   Run2Test("Msort")
   cart("msort")

  outcome("MATRIX")
   }


/////////////////////////////////////////

 if ((do_all || do_dynv ) && (do_dynv != -1)) {
    inflsz = caz(FailList)
    //hdg("DYNAMIC_V")

    RunDirTests("Dynv","dynv");
  outcome("DYNV")

    }

/////////////////////////////////////////

if ((do_all || do_lhsubsc )   && (do_lhsubsc != -1)) {
      inflsz = caz(FailList)
  RunDirTests("Subscript","vecsubset,lharraysubsrange")
  outcome("SUBSCRIPT")
    }

/////////////////////////////////////////

if ((do_all || do_func ) && (do_func != -1)) {
    inflsz = caz(FailList)

//  Run2Test("Func")
  


  RunDirTests("Func","func,repeat_func_call")

  //do_carts("func", 3)
  
 //   cart("func","3")
 //   cart_xic("func","4")


  RunDirTests("Args","args")



 // RunDirTests("Func","func")  


  //Run2Test("Ifunc")
  //do_carts ("ifunc")   //TBC

  //Run2Test("Iproc")
  //do_carts ("iproc")   //TBC

  outcome("FUNC")
}


if ((do_all || do_iproc ) && (do_iproc != -1)) {
    inflsz = caz(FailList)

  RunDirTests("Iproc","iproc")

 outcome("IPROC")

}


/////////////////////////////////////////

   if ((do_all || do_vmf) && (do_vmf != -1)) {
    inflsz = caz(FailList)
    RunDirTests("Vmf","vmf_trim,vmf_range,vmf_cut,vmf_substitute,genv")
    RunDirTests("Vmf","vmf_prune,vmf_bubblesort,vmf_rotate,vmf_white")    
    outcome("VMF")
 }

/////////////////////////////////////////


if ((do_all || do_unary ) && (do_unary != -1)) {
    inflsz = caz(FailList)

  RunDirTests("Unary","unaryif,unaryexp")
  outcome("UNARY")
}

/////////////////////////////////////////
//rdb()
   if ((do_all || do_command ) && (do_command != -1)) {
    inflsz = caz(FailList)
     RunDirTests("Command","command,command_parse")
     outcome("COMMAND")
    }


/////////////////////////////////////////
if ((do_all || do_proc ) && (do_proc != -1)) {
  inflsz = caz(FailList)
  
  //RunDirTests("Proc","procdeclare,proc,procret,procarg,procsv0");
  RunDirTests("Proc","procdeclare,proc,procret,procsv0");
  RunDirTests("ProcCall","proccall")
  RunDirTests("Proc","procrefarg,procra,procrefstrarg,proclocmainvar")

  RunDirTests("Proc","proc_var_define,procnest_args");
  
  RunDirTests("ProcArray","procarray,poffset,arrayarg1,arrayarg2")


  

  


  //pgn = "proc_var_define";
  //cart(pgn, 10)
  
  RunDirTests("Static","static");

   outflsz = caz(FailList)

   outcome("PROC")

  
  }

//rdb()
  if ((do_all || do_scope ) && (do_scope != -1)) {
    inflsz = caz(FailList)
   RunDirTests("Scope","scope") ; 

  outcome("SCOPE")
  }


 chdir(Testdir)

if ((do_all || do_recurse ) && (do_recurse != -1)) {
    inflsz = caz(FailList)
     //hdg("RECURSION")
    
     RunDirTests("Fact","fact")
     
     //str pgn = "fact"
     
     //cart(pgn, "10")

     //cart_xic(pgn,"10")
  outcome("RECURSE")

}



if ((do_all || do_mops ) && (do_mops != -1)) {

   inflsz = caz(FailList)

    RunDirTests("Mops","mops")

    RunDirTests("Rand","rand")

    RunDirTests("Cmplx","cmplx")



    outcome("MOPS")
    }


   if ((do_all || do_svar ) && (do_svar != -1)) {

    inflsz = caz(FailList)

    RunDirTests("Svar","svar");

    RunDirTests("Hash","hash,svar_table,svar_hash");

    outcome("SVAR")
    }

  if ((do_all || do_ivar ) && (do_ivar != -1)) {
    inflsz = caz(FailList)
     RunDirTests("Ivar","ivar")
    outcome("IVAR")
    }


  if ((do_all || do_record ) && (do_record != -1)) {

       inflsz = caz(FailList)

   RunDirTests("Record","record,recread,recprt,recatof,reclhs,rectest,recmd,recdyn");
   outcome("RECORD")
  }

chdir(Testdir)

 if ((do_all || do_mops ) && (do_mops != -1)) {
      inflsz = caz(FailList)
    RunDirTests("Math","inewton,inewton_cbrt,opxeq")

/*
     Run2Test("Prime")
    //    cart ("prime_65119")
    cart ("prime_127")
*/

      RunDirTests("Pow","pow")
      outcome("MATH")
    }


 chdir(Testdir)

 if ((do_all || do_stat ) && (do_stat != -1)) {
    inflsz = caz(FailList)
    hdg("STAT")

    RunDirTests("Polynom","checkvm,polynom")
     outcome("STAT")
}

 if ((do_all || do_pan )  && (do_pan != -1)) {
    inflsz = caz(FailList)
    hdg("PAN")
// TBD - more tests -- xic is using double for pan consts??
    //RunDirTests("Pan","pan,pan-loop-test,pancmp,panarray")
    RunDirTests("Pan","pan,pancmp,panarray")

   // cart("derange","100") ; /// TBF
     outcome("PAN")
 }


   if ((do_all || do_lists ) && (do_lists != -1)) {
     inflsz = caz(FailList)
     RunDirTests("Lists","lists,listdeclare,listele,listinsdel");
     outcome("LISTS")
    }

   if ((do_all || do_ptrs ) && (do_ptrs != -1)) {
       inflsz = caz(FailList)
      RunDirTests("Swap","swap,swap1");
      RunDirTests("Ptrs","ptrs,ptr_vec,ptr_numvec,ptr_svarvec,ptr_varvec,indirect");
      outcome("PTRS")
   }



 if ((do_all || do_sfunc ) && (do_sfunc != -1)) {
    inflsz = caz(FailList)
    //hdg("S-FUNCTIONS")

    RunSFtests("Fio,Sscan,Scpy,Fscanf,Bscan,Cut,Cmp,Sel,Shift,Median,Findval,Lip");
    

   RunSFtests("Ltm,Pow,Minof,Maxof,Ftest,Convert,Return,Dec2,Pincdec,Rowzoom");

   RunSFtests("Quicksort,Readfile,Skeyval,ReadRecord,Icall");



//============================
    RunSFtests("BubbleSort,Typeof,Variables,Trig,Caz,Sizeof,Limit,D2R,Cbrt,Fabs");
    RunSFtests("Round,Trunc,Wdata,Fscanv,Cmpsetv,Vrange,MDRange,Flipdim");

//============================

    RunDirTests("Funcs","abs");


/// chem    -- find an atomic number for an element

    RunDirTests("Chem","chem0")

    RunDirTests("Packb","packb,packalot");
    
//============================    
  outcome("SFUNC")
    }






//////////////////// BUGFIXs/////////////////////////////////////////
  
  if ((do_all || do_bugs )  && (do_bugs != -1)) {
      inflsz = caz(FailList)
      //cart("bf_40")   // this has intentional error and exits before test checks
    chdir(Testdir)

     chdir("BUGFIX")
<<"Doing bug tests"
//!!"pwd"
/*
BFS=!!"ls bf*.asl "
//<<"$(typeof(BFS)) $BFS\n"
bflist="$BFS"

   bug_list = ssub(bflist,".asl"," ,",0)
   bug_list = scut(ssub(bug_list," ","",0),-1)
<<[_DBH]"$bug_list\n"

      RunDirTests("BUGFIX",bug_list)
      outcome("BUGFIX")
*/      
  }


  if ((do_all || do_tests ) && (do_tests != -1)) {
    inflsz = caz(FailList)
    chdir(Testdir)
//  get a list of asl files in this dir and run them
     chdir("Tests")
//<<"Doing Tests"
//!!"pwd"

  TS=!!"ls *.asl"

<<"$(typeof(TS)) $TS\n"
//<<"$TS\n"

 tslist="$TS"

//<<"$(typeof(tslist)) $tslist\n"

<<[_DBH]" $tslist\n"

 //  test_list = ssub(tslist,".asl",",",0)
   test_list = ssub(tslist,".asl",",",0)
   test_list = scut(ssub(test_list," ","",0),-1)
   
//<<"%V $test_list\n"
  RunDirTests("Tests",test_list);
  outcome("TESTS")    
  }

/*
if ((do_all || do_threads )) {
        Run2Test("Threads")
        cart("threads")
    
}
*/
  ///////////////////////////////////////////////////////////////////////////////////////////


// and the Grand Total is ???
   if (rt_tests <=0)
       rt_tests =1;
   pcc = rt_pass/(1.0*rt_tests) * 100

   flsz = caz(FailList)
   

    fseek(Tlogf,0,2)



  if (flsz >= 1) {


<<[Opf]"\n$flsz modules  failed! \n"
<<[Tlogf]"\n$flsz modules  failed! \n"

   FailList.Sort()

//<<" %(2,\t, ,\n)$FailList \n"  // would like this to work like for vectors ---

   for (i = 0; i < flsz ; i++) {
       <<"\t\t\t$FailList[i]"

    if (i> 0)
       <<"\n"
       
       <<[Opf]"$FailList[i]"

      <<[Tff]"$FailList[i] \n"
       
       <<[Tlogf]"$i $FailList[i] \n"       
    }
}

//<<"\n----------------------------------------------------------------------------\n"

   flsz = caz(FailList)
   lsz = caz(CrashList)
   
<<"FailList size $flsz CrashList size $lsz \n"

   

if (lsz > 0) {

<<"\n\t\t\t$lsz modules   crashed! \n"
<<[Opf]"\n$lsz modules   crashed! \n"
<<[Tlogf]"\n$lsz modules   crashed! \n"


  // CrashList.pinfo();
   CrashList.Sort()

//<<" crashlist $lsz   \n"
   for (i = 0; i < lsz ; i++) {
   <<"\t\t\t$i $CrashList[i]"
    if (i> 0)
       <<"\n"
   <<[Opf]"$CrashList[i] \n"
   <<[Tcf]"$CrashList[i] \n"
   <<[Tlogf]"$i $CrashList[i] \n"
//   if (i > clsz)       break;
   }
   
}




if (!do_module) {
<<"\n----------------------------------------------------------------------------\n"
if (Nsuites == 0) {
 Nsuites = 1
}
   len = slen(Test_suite);
   Pad = nsc(16-len," ")


<<"$(slower(Test_suite)) $Pad%6.3f$pcc %d \t$n_modules\t$rt_tests\t$rt_pass\t$rt_fail\t$rtx_fail\t$lsz\tvers $(get_version()) $(date(1))\n"
<<"TestSuites: $Nsuites passed $Nspassed  %6.2f $(Nspassed/(Nsuites*1.0) *100.0)%%\n"  
<<[Opf]"$(date(1)) Modules $n_modules Tests $rt_tests    Passed   $rt_pass Fail $rt_fail Xfail $rtx_fail  Crash $lsz Score %6.2f$pcc $(get_version())\n" 
<<[Tlogf]"$(date(1)) Modules $n_modules Tests $rt_tests  Passed   $rt_pass Fail $rt_fail Xfail $rtx_fail  Crash $lsz Score %6.2f$pcc $(get_version())\n"    
}

fflush(Opf)
cf(Opf)

fflush(Tcf)
cf(Tcf)

fflush(Tff)
cf(Tff);
fflush(Tlogf)
cf(Tlogf);
chdir(cwd)

//!!"pwd"

//<<"cp Scores/score_$(date(2,'-')) current_score \n"

ut=utime()

  //ut.aslpinfo();
  

!!"mkdir -p Tresults"

A=ofw("Tresults/score_$ut");
cdate = date(1)
vers = getVersion()
<<[A]"$ut $cdate Modules $n_modules Tests $rt_tests  Pass $rt_pass  Score %6.2f$pcc Fail %d$flsz Crash $lsz it $i_time xt $x_time vers $vers \n"
cf(A)





wd=chdir(hdir)
wdir = getdIr()
//<<"%V $wd $hdir $wdir\n"

//ans=query("where are we")
//!!"ls "

 cdate = date(2,'-')

!!"cp current_score Scores/score_${cdate} "

dtms= FineTimeSince(TM);
float secs = dtms/1000000.0

if (!do_module) {

//<<"script vers $hdr_vers took %6.3f$secs secs %d %V $i_time $x_time\n"

<<"script vers $Hdr_vers took %6.3f$secs secs\n"

<<"%6.3f$secs secs %d %V $i_time $x_time\n"

today=getDate(1);
<<"used $wasl for tests \n"

!!"$wasl -v"
<<"$today tested $(get_version())\n"
 if (lsz >0) {
   pcc -= lsz;
 }
sipause(1)
if (pcc < 100.0) {
<<"%6.2f $pcc \% fixes needed!! \n"
<<"\n$lsz modules   crashed! \n"
}
else {
<<"$pcc % Success nothing to fix Hooray! \n"
}

}
exit(0)


//// TBD///
/*

select/reject  test of item

*/



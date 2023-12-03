/* 
 *  @script ASL_TEST_VER.asl                                            
 * 
 *  @comment asl test modules                                           
 *  @release Beryllium                                                  
 *  @vers 1.64 Gd Gadolinium [asl 6.4.80 C-Be-Hg]                       
 *  @date 03/12/2023 12:15:34                                           
 *  @cdate 1/1/2005                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2023 -->                               
 * 
 */ 
//----------------<v_&_v>-------------------------//;                  


//
// test asl first and second stage (xic)
//



#include "debug.asl"


if (_dblevel > 0) {
   debugON()
}


#include "hv.asl"


int inflsz = 0;
int outflsz = 0;


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


//<<"using $wasl for testing \n"

!!"asl -v"

!!"mkdir -p Scores"



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

//ans=query("where are we")


//str S = "all,array,matrix,bugs,bops,vops,sops,fops,class, declare,include,exp,if,logic,for,do,paraex,proc,switch,try"
//S.cat("types,func,command,lhsubsc,dynv,mops,scope,oo,sfunc,svar,record,ivar,lists,stat,threads,while,pan,unary,ptrs,help");

str S = "all array bops bugs class command declare do dynv exp fops for func help if include ivar lhsubsc lists logic"
S.cat("matrix mops oo pan paraex proc ptrs record redimn resize scope sfunc sops stat svar switch threads try types unary vops while");


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
int rt_crash = 0
int rt_fail = 0
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

CFLAGS = "-cwl"

//CFLAGS = "-cwlm"     // m to mask src lines in exe file --- broke

ntest = 0


 
int do_all = 1;
int do_level2 = 0;
int do_query = 0;
int do_help = 0;
int do_module = 0;
int do_release = 0;





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



 CrashList = ( "xxx",  )  // empty list
 
 CrashList.LiDelete(0) ; // make empty

 FailedList = ( "fail",  )  // empty list --- bug first item null? 
 FailedList.LiDelete(0)
 



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

    if (wt @= "") {
      break
    }
    
     if (wt @= "bops") {
        do_bops = 1  
     }
   
      do_arg = "do_$wt"
     

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

<<[_DBH]"%V $do_all $do_bops $do_mops \n"


//================



if (do_release) {
  wasl = "aslx"
//  <<"testing release vers \n"
  !!"$wasl -v"
}


if (do_level2) {
    do_bops =1;
    do_syntax =1;
    do_types =1;    
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
 //do_try = 1;  
}

if (do_syntax == -1) {

 do_if = -1;
 do_logic = -1;
 do_for = -1;
 do_do = -1;
 do_switch = -1;
 do_while = -1;
 do_scope = -1;
 do_include = -1;  

}

if (do_math) {
    do_mops = 1;
}


//<<" check Include $do_include $do_types\n"

//<<"%V $do_query\n"


if ((do_include || do_all ) && (do_include != -1)) {

  Run2Test("Include")

  cart("include")

  //RunDirTests("Include","include")
  outcome("INCLUDE")
}

//================================//

  if ((do_bops || do_all) && (do_bops != -1)) {

    inflsz = caz(FailedList)

    RunDirTests("Bops","bops,fvmeq,fsc1,mainvar,snew");
    


   RunDirTests("Assign","assign");

    Run2Test("Bops")


// !!!! if basics fail warn/ask before going on to rest of testsuite
  rt_script = "bops"
  rt_arg1 = "7"
  cart(rt_script,rt_arg1)

  cart_xic(rt_script,rt_arg1)
  rt_script = "fvmeq"
  cart(rt_script,rt_arg1)

  cart_xic(rt_script,rt_arg1)
  updir()

  chdir ("Contin")
  //changeDir("Contin")

  cart("contin")

  updir()

  chdir("Mod")

  cart("mod")

  updir()


  chdir("Info")

  do_carts("info")

   //RunDirTests("Assign","assign");
  outcome("BOPS")
   }

////////////// OO ///////////////////////


   if ((do_all || do_class )  && (do_class != -1)) {
    inflsz = caz(FailedList)
        RunDirTests("Class","classbops,class_mfcall,class2,classvar");
       outcome("CLASS")
    }



   if ((do_all || do_oo ) && (do_oo != -1)) {
    inflsz = caz(FailedList)

    //RunDirTests("OO","oa2,rpS,rp2,wintersect,oa,class_array,simple_class");
    RunDirTests("OO","oa2,rpS,rp2,oa,class_array,simple_class");

    RunDirTests("Obcopy","obcopy,obprocarg");

    RunDirTests("Mih","sh,mih")

    outcome("OO")
  }


////////////// IF ///////////////////////

if ((do_if || do_all) && (do_if != -1)) {
    inflsz = caz(FailedList)
  
    RunDirTests("If","if,ifand")



    outcome("IF")


  }
////////////////////////////////////////////////////////////////////////

////////////// Define ///////////////////////

if ((do_define || do_all) && (do_define != -1)) {
      inflsz = caz(FailedList)
  RunDirTests("Define","define")


  outcome("DEFINE")
  }
////////////////////////////////////////////////////////////////////////

////////////// Enum ///////////////////////

if ((do_enum || do_all) && (do_enum != -1)) {

    inflsz = caz(FailedList)
    RunDirTests("Enum","enum,colors_enum")

    outcome("ENUM")
  }
////////////////////////////////////////////////////////////////////////




if ((do_bit || do_all) && (do_bit != -1)) {
    inflsz = caz(FailedList)
//  Run2Test("Bitwise");
//  cart("bitwise");
   RunDirTests("Bitwise","bitwise")
   outcome("BITWISE")
}



  if ((do_logic || do_all) && (do_logic != -1)) {
  
   inflsz = caz(FailedList)
   //<<"%V $inflsz \n"

   RunDirTests("Compare","compare")

   RunDirTests("Logic","logic,logic_ops,logic_def")


  outcome("LOGIC")

  }

 if ((do_for || do_all) && (do_for != -1)) {

  inflsz = caz(FailedList)

  RunDirTests("For","for,for-exp")
   
  
  outcome("FOR")

}


////////////////////////////////////////////////////////////////////////
 

  if ((do_all || do_while ) && (do_while != -1)) {
        inflsz = caz(FailedList);
       RunDirTests("While","while_nest,while")
      outcome("WHILE")
    }
////////////////////////////////////////////////////////////////////////






if ((do_all || do_do ) && (do_do != -1)) {
    inflsz = caz(FailedList)
      RunDirTests("Do","do")
      outcome("DO")
    }

if ((do_all || do_try ) && (do_try != -1)) {
    inflsz = caz(FailedList)
      RunDirTests("TryThrowCatch","trythrowcatch")
outcome("TRY")
    }
////////////////////////////////////////////////////////////////////////


//======================================//
    if ((do_switch || do_all) && (do_switch != -1)) {

       inflsz = caz(FailedList)
     

       RunDirTests("Switch","switch")

       outcome("SWITCH")
   }

//======================================//

    if ( (do_types || do_all) && (do_types != -1)) {
      inflsz = caz(FailedList)
      RunDirTests("Types","types");
      
      RunDirTests("Cast","cast,cast-vec")

      RunDirTests("Efmt","efmt",);

      RunDirTests("Swab","swab")
outcome("TYPES")
      //rdb()
  }
//======================================//

  if ((do_vops || do_all ) && (do_vops != -1)) {
    inflsz = caz(FailedList)


     RunDirTests("Vops","vops")
outcome("VOPS")
    inflsz = caz(FailedList)
     RunDirTests("Vector","vector")
outcome("VECTOR")
     RunDirTests("Reverse","reverse") ; // BUG needs more than one
  }



//////////////////////////////////////////////////

  if ( (do_sops || do_all) && (do_sops != -1)) {
      //  need more str ops tests than this!
    inflsz = caz(FailedList)
   RunDirTests("Sops","sops");

    outcome("SOPS")
 
  // RunDirTests("Str","str-proc,str-arg,str-lit");
    inflsz = caz(FailedList)
  RunDirTests("Str","str_proc,str_arg");

outcome("STR")
   //hdg("Strops");
   
   RunDirTests("Strops","scmp_syntax");

 //  hdg("Splice");
   RunDirTests("Splice","splice,strsplice");
 
  // make this a pattern OP

 // RunSFtests("Date,Sele,Sstr,Spat,Str,Split,Regex,Fread,Trunc,Tranf");
   RunSFtests("Scmp,Date,Sele,Sstr,Spat,Split,Regex,Fread,Trunc,Tranf");


  }

/////////////////////////////////////////////////

  if ((do_fops || do_all) && (do_fops != -1)) {
    inflsz = caz(FailedList)
  RunDirTests("Fops","fops")
  RunDirTests("Fh","fh")  


  // need to do  script arg1 agr2 ...
  RunDirTests("Fexist","fexist")

    outcome("FOPS")




  }
//======================================//

if ((do_all  || do_declare ) && (do_declare != -1))  {

    inflsz = caz(FailedList)
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

    inflsz = caz(FailedList)

   RunDirTests("Sexp","sexp");


outcome("EXP")

    }

//rdb()

 if ((do_all || do_paraex ) && (do_paraex != -1)) {
    inflsz = caz(FailedList)
  Run2Test("ParaEx")

  cart("paraex")

outcome("PARAEX")


 }


/////////////// ARRAY //////////////////////

if ((do_all || do_array ) && (do_array != -1)) {

  inflsz = caz(FailedList)

  RunDirTests("VVcomp","vvcomp");

  RunDirTests("Vfill","vfill");


   RunDirTests("Subrange","subrange");

   RunDirTests("VVcopy","range_copy,vvcopy")

  RunDirTests("ArraySubSet","arraysubset,array_subvec,array_subsref,arraysubscbyvec,array_ele_incr,vdec")

   RunDirTests("Array","ae,array_cmp,array_ele")

   RunDirTests("Array","dynarray,lhe,vec_cat,array_sr,md_ele,vsp")

   RunDirTests("ArrayRange","arrayrange,array_subsrange,lhrange")

  

  RunDirTests("ArrayJoin","arrayjoin")

  RunDirTests("Scalarvec","scalarvec")

  RunDirTests("Vgen","vgen,vgen_pan")

  RunDirTests("PrePostOp","prepostop");

 // Run2Test("PrePostOp")
//   do_carts("prepostop")

  RunDirTests("M3D","m3d,m3d_assign")

  RunDirTests("Sgen","sgen")

  //do_carts("sgen")

   RunDirTests("VVgen","vvgen")

  outcome("ARRAY")


    }


/////////////////////////////////////////

 if ((do_all || do_matrix ) && (do_matrix != -1)) {
     inflsz = caz(FailedList)
   RunDirTests("Mdimn","mdimn")


   RunDirTests("Matrix","mat_mul,mat_inv,mat_sum,msquare,mdiag");
   

   Run2Test("Msort")
   cart("msort")

  outcome("MATRIX")
   }


/////////////////////////////////////////

 if ((do_all || do_dynv ) && (do_dynv != -1)) {
    inflsz = caz(FailedList)
    //hdg("DYNAMIC_V")

    RunDirTests("Dynv","dynv");
  outcome("DYNV")

    }

/////////////////////////////////////////

if ((do_all || do_lhsubsc )   && (do_lhsubsc != -1)) {
      inflsz = caz(FailedList)
  RunDirTests("Subscript","vecsubset,lharraysubsrange")
  outcome("SUBSCRIPT")
    }

/////////////////////////////////////////

if ((do_all || do_func ) && (do_func != -1)) {
    inflsz = caz(FailedList)

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
    inflsz = caz(FailedList)

  RunDirTests("Iproc","iproc")

 outcome("IPROC")

}


/////////////////////////////////////////

   if ((do_all || do_vmf) && (do_vmf != -1)) {
    inflsz = caz(FailedList)
    RunDirTests("Vmf","vmf_trim,vmf_range,vmf_cut,vmf_substitute,genv")
    RunDirTests("Vmf","vmf_prune,vmf_bubblesort,vmf_rotate,vmf_white")    
    outcome("VMF")
 }

/////////////////////////////////////////


if ((do_all || do_unary ) && (do_unary != -1)) {
    inflsz = caz(FailedList)

  RunDirTests("Unary","unaryif,unaryexp")
  outcome("UNARY")
}

/////////////////////////////////////////
//rdb()
   if ((do_all || do_command ) && (do_command != -1)) {
    inflsz = caz(FailedList)
     RunDirTests("Command","command,command_parse")
  outcome("COMMAND")
    }


/////////////////////////////////////////
if ((do_all || do_proc ) && (do_proc != -1)) {
  inflsz = caz(FailedList)
  RunDirTests("Proc","proc,procdeclare,procret,procarg,procsv0");

  RunDirTests("Proc","procrefarg,procra,procrefstrarg,proc_loc_main_var,proc_var_define,procnest_args");
  
  RunDirTests("ProcArray","procarray,poffset,arrayarg1,arrayarg2")

  RunDirTests("ProcCall","proccall")
  

  


  //pgn = "proc_var_define";
  //cart(pgn, 10)
  
  RunDirTests("Static","static");

   outflsz = caz(FailedList)

   outcome("PROC")

  
  }

//rdb()
  if ((do_all || do_scope ) && (do_scope != -1)) {
    inflsz = caz(FailedList)
   RunDirTests("Scope","scope") ; 

  outcome("SCOPE")
  }


 chdir(Testdir)

if ((do_all || do_recurse ) && (do_recurse != -1)) {
    inflsz = caz(FailedList)
     //hdg("RECURSION")
    
     RunDirTests("Fact","fact")
     
     //str pgn = "fact"
     
     //cart(pgn, "10")

     //cart_xic(pgn,"10")
  outcome("RECURSE")

}



if ((do_all || do_mops ) && (do_mops != -1)) {

   inflsz = caz(FailedList)

    RunDirTests("Mops","mops")
     
    RunDirTests("Cmplx","cmplx")

    RunDirTests("Rand","rand")

    outcome("MOPS")
    }


   if ((do_all || do_svar ) && (do_svar != -1)) {

    inflsz = caz(FailedList)

    RunDirTests("Svar","svar");

    RunDirTests("Hash","hash,svar_table,svar_hash");

    outcome("SVAR")
    }

  if ((do_all || do_ivar ) && (do_ivar != -1)) {
    inflsz = caz(FailedList)
     RunDirTests("Ivar","ivar")
    outcome("IVAR")
    }


  if ((do_all || do_record ) && (do_record != -1)) {

       inflsz = caz(FailedList)

   RunDirTests("Record","record,rec_read,rec_prt,rec_atof,rec_lhs,rec_test,rec_md,rec_dyn");

  outcome("RECORD")
  }
 chdir(Testdir)

 if ((do_all || do_mops ) && (do_mops != -1)) {
      inflsz = caz(FailedList)
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
    inflsz = caz(FailedList)
//    hdg("STAT")

    RunDirTests("Polynom","checkvm,polynom")
}

 if ((do_all || do_pan )  && (do_pan != -1)) {
    inflsz = caz(FailedList)
    hdg("PAN")
// TBD - more tests -- xic is using double for pan consts??
    //RunDirTests("Pan","pan,pan-loop-test,pancmp,panarray")
    RunDirTests("Pan","pan,pancmp,panarray")

   // cart("derange","100") ; /// TBF
     outcome("PAN")
 }


   if ((do_all || do_lists ) && (do_lists != -1)) {
     inflsz = caz(FailedList)
     RunDirTests("Lists","list_declare,lists,list_ele,list_ins_del");
     //RunDirTests("Lists","lists");
     outcome("LISTS")
    }

   if ((do_all || do_ptrs ) && (do_ptrs != -1)) {
       inflsz = caz(FailedList)
      RunDirTests("Swap","swap,swap1");
      RunDirTests("Ptrs","ptrs,ptr_vec,ptr_numvec,ptr_svarvec,ptr_varvec,indirect");
      outcome("PTRS")
   }



 if ((do_all || do_sfunc ) && (do_sfunc != -1)) {
    inflsz = caz(FailedList)
    //hdg("S-FUNCTIONS")

    RunSFtests("Fio,Sscan,Scpy,Fscanf,Bscan,Cut,Cmp,Sel,Shift,Median,Findval,Lip");
    

   RunSFtests("Pow,Minof,Maxof,Ftest,Convert,Return,Dec2,Pincdec,Rowzoom");

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
      inflsz = caz(FailedList)
      //cart("bf_40")   // this has intentional error and exits before test checks
    chdir(Testdir)

     chdir("BUGFIX")
//<<"Doing bug tests"
//!!"pwd"

BFS=!!"ls bf*.asl "
//<<"$(typeof(BFS)) $BFS\n"
bflist="$BFS"

   bug_list = ssub(bflist,".asl"," ,",0)
   bug_list = scut(ssub(bug_list," ","",0),-1)
<<[_DBH]"$bug_list\n"

      RunDirTests("BUGFIX",bug_list)
      outcome("BUGFIX")
  }


  if ((do_all || do_tests ) && (do_tests != -1)) {
    inflsz = caz(FailedList)
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

   flsz = caz(FailedList)
   

    fseek(Tlogf,0,2)



  if (flsz >= 1) {


<<[Opf]"\n$flsz modules  failed! \n"
<<[Tlogf]"\n$flsz modules  failed! \n"

   FailedList.Sort()

//<<" %(2,\t, ,\n)$FailedList \n"  // would like this to work like for vectors ---

   for (i = 0; i < flsz ; i++) {
       <<"\t\t\t$FailedList[i]"

    if (i> 0)
       <<"\n"
       
       <<[Opf]"$FailedList[i]"

      <<[Tff]"$FailedList[i] \n"
       
       <<[Tlogf]"$i $FailedList[i] \n"       
    }
}

//<<"\n----------------------------------------------------------------------------\n"

  
   lsz = caz(CrashList)
//<<"failed list size $flsz crash $lsz \n"
//   flsz<-info(1)
//   lsz<-info(1)
   

if (lsz >= 1) {

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
<<"$(date(1)) Modules $n_modules Tests $rt_tests  Passed $rt_pass  Score %6.2f$pcc Fail %d$flsz Crash $lsz vers $(get_version())\n"
<<"TestSuites: $Nsuites passed $Nspassed  %6.2f $(Nspassed/(Nsuites*1.0) *100.0)%%\n"  
<<[Opf]"$(date(1)) Modules $n_modules Tests $rt_tests  Passed $rt_pass  Score %6.2f$pcc Fail %d$flsz Crash $lsz $(get_version())\n"
<<[Tlogf]"$(date(1)) Modules $n_modules Tests $rt_tests  Passed $rt_pass  Score %6.2f$pcc Fail %d$flsz Crash $lsz $(get_version())\n"    
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
<<"$pcc % Success Hooray! \n"
}

}
exit(0)


//// TBD///
/*

select/reject  test of item

*/



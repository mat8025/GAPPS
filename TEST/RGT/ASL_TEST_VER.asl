//%*********************************************** 
//*  @script ASL_TEST_VER.asl 
//* 
//*  @comment asl test modules 
//*  @release CARBON 
//*  @vers 1.57 La Lanthanum                                               
//*  @date Fri Jul 19 08:53:42 2019 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

//
// test asl first and second stage (xic)
// 
include "debug.asl"
include "hv.asl"

debugON()

#define PGREEN '\033[1;32m'
#define PRED '\033[1;31m'
#define PBLACK '\033[1;39m'
#define POFF  '\033[0m'


wasl = "aslx"   // alsx should be stable
wasl = "asl"
<<"using $wasl for testing \n"

//ws= getenv("GS_SYS")

!!"rm -f ../*/*.tst"
!!"rm -f ../*/*.xtst"
!!"rm -f ../*/*.out"
!!"rm -f ../*/*.xout"

// do not remove our own debug

//!!"rm -f ../*/*.idb"
//!!"rm -f ../*/*.xdb"



setdebug(1,@keep,@~pline,@~step,@~trace)
filterFuncDebug(ALLOWALL_,"proc");
filterFileDebug(ALLOWALL_,"ic_op");



//envdebug();
//str S = "all,array,matrix,bugs,bops,vops,sops,fops,class, declare,include,exp,if,logic,for,do,paraex,proc,switch, types,func,command,lhsubsc,dynv,mops,scope,oo,sfunc, svar,record,ivar,lists,stat,threads,while,pan,unary,ptrs,help";

str S = "all,array,matrix,bugs,bops,vops,sops,fops,class, declare,include,exp,if,logic,for,do,paraex,proc,switch,"
S->cat("types,func,command,lhsubsc,dynv,mops,scope,oo,sfunc, svar,record,ivar,lists,stat,threads,while,pan,unary,ptrs,help");


Svar Opts[] = Split(S,",");


//<<"$Opts \n"




//<<"$Testdir\n"
TM= FineTime();

today=getDate(1);
<<"$today $(get_version())\n"

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

do_xic = 1;

int n_modules = 0
int rt_tests = 0
int rt_pass = 0
int rt_fail = 0
int i_time = 0;
int x_time = 0;


Todo=ofw("to_test")


//////////////////////////////
Ks = 0
proc snooze(int ksn)
{
Ks = 0
  for (ks = 0; ks < ksn; ks++) {
    Ks++
  }
}
//===============================

proc runModule (int wmod)
{

   int ret =0;
   
   if (do_all && (wmod != -1)) {
      ret = 1;
  //    <<"RUN %V $do_all $wmod\n"
   }
   
   if (wmod ==1) {
    //  <<"RUN %V $wmod\n"
      ret =1;
   }
  if ( wmod == -1) {
     // <<"DONT RUN %V $wmod\n"
      ret =0;
  }
//<<"$_proc  $wmod  $ret \n"
  return ret;
}


padtit =nsc(15,"/")

proc hdg(str atit)
{

len = slen(atit)

<<"\n$(time()) ${padtit}${atit}$(nsc(20-len,\"/\"))\n"
<<[Opf]"\n$(time()) ${padtit}${atit}$(nsc(20-len,\"/\"))\n"

//!!"ps wax | grep asl | grep -v emacs"
}
//===============================
Curr_dir = "xx";

proc help()
{
 <<" run regression tests for asl\n"
 <<" asl ASL_TEST_VER \n"
 <<" runs all tests \n"
 <<" asl ASL_TEST_VER bops mops\n"
 <<" would run basic and math regression tests and return scores\n"
 <<" asl ASL_TEST_VER all pause\n"
 <<" would run every test -pausing at end of each rof keyboard input to continue\n"
 
 <<" current tests:\n"
 <<" %(5,, ,\n) $Opts \n"

}
//==========================//



proc changeDir(str td)
{
  chdir(td)
  Curr_dir = getDir();
}
//===============================

proc Run2Test(str td)
{

  changeDir(Testdir)

//!!"pwd"

  hdg(td)

  Prev_dir = getDir();

  chdir(td)
  
  Curr_dir = getDir();
  
  //<<"changing to $td dir from $Prev_dir in $Curr_dir\n"
}
//===============================


proc RunDirTests(str Td, str Tl )
{
      Run2Test(Td);
      Tl->DeWhite()
      Tp = Split(Tl,",");

      np = Caz(Tp);
      <<[Dbf]"$Td $Tl $np\n"
      for (i=0 ; i <np; i++) {
         if (!(Tp[i] @= "")) {
           cart(Tp[i]," ");
	   }
      }
}
//====================//

proc RunSFtests(Td)
{
// list of dirs  Fabs,Cut,Cmp ...
// goto dir then run cart(fabs) or cart(cmp)

      Tp = Split(Td,",");

      np = Caz(Tp);
      for (i=0 ; i < np; i++) {
         wsf = Tp[i];
         Run2Test(wsf);
	 wsf = slower(wsf);
         cart(wsf," ");
      }
}


/////////////////////////////

proc scoreTest(str tname)
{
 int scored = 0;
 int ntests;
 int npass;

 int ntests2;
 int npass2;
 
        RT=ofr(tname);
       
//<<"$_proc $tname fh $RT \n"


       if (RT != -1) {
//<<"$tname\n"
/{/*
       tstf = readFile(RT);
       <<"/////\n"
       <<"$tstf"
       <<"/////\n"
/}*/       
          posn = fseek(RT,0,2)
//<<"EOF @ $posn\n";

          posn =seekLine(RT,-1);
//<<"LL @ $posn\n";

          rtl = readline(RT)
//<<"%V<$rtl>\n"	  
          rtwords = Split(rtl);
//<<"%V $rtwords \n"

          ntests2 = atoi(rtwords[4]); // TBF returns vec size 2??
          npass2 =  atoi(rtwords[6]);

          rtw4 = rtwords[4];
	  rtw6 = rtwords[6];

//<<"%V $rtw4 $rtw6\n"

          ntests = atoi(rtw4);
	  npass = atoi(rtw6);
	  
 //<<"%V $rtwords[4] $rtwords[6]\n"


// <<"%V $ntests $npass\n"
// <<"%V $ntests2 $npass2\n"
          if (ntests > 0) {
          pcc = npass/(ntests*1.0) *100
          }
	  else {
          pcc = 0.0;
          }
          rt_tests += ntests;
          rt_pass += npass;
	  took = rtwords[12];
	  tmsecs =atoi(took);
	  wextn = scut(tname,-4);
	 // <<"$tname $wextn \n"
          if ((sele(tname,-1,-4)) @= "xtst") {
            x_time += tmsecs; 
	    	    //<<"%V $x_time\n"
          }
	  else {
	    i_time += tmsecs;
	    //<<"%V $i_time\n"
          }
	  
if (pcc < 100){
 <<"$(PRED)DONE tests $ntests\tpass $npass\tscore %5.2f$pcc\%$(POFF) took $took msecs\n"
}
else {
 <<"DONE tests $ntests\tpass $npass\tscore %5.2f$pcc\% took $took msecs\n"
}

<<[Opf]"DONE tests $ntests\tpass $npass\tscore %5.2f$pcc\%\n"
 
          cf(RT)

          scored = 1;

          n_modules += 1 

          if (pcc != 100.0) {
	  //<<"${Curr_dir} inserting $tname into failed list \n"
            FailedList->Insert("${Curr_dir}/${tname}")
	  //<<[Tff]"${Curr_dir}/${tname}\n"  
          }
       }

    return scored;
}
//===============================





int cbh = 0

proc doxictest(str prog, str a1)
{
//<<"IN $prog\n"

 if (f_exist("${prog}") != -1) {

//<<"$prog exists!\n"
  !!"rm -f last_xic_test"

  prg = scut(prog,2);
  if (_pargc > 1) {

//<<"XIC test  $prog $a1\n"

       // !!"nohup $prog  $a1 >> $ictout "

//      !!" $prog  $a1 > xres.txt "

       !!"$wasl -o ${prog}.xout -e ${prog}.xerr -t ${prog}.xtst -dx $prog $a1  > foox-$prg"

      //!!" $prog  $a1  | tee --append $ictout "
  }
  else {

  //    <<"XIC test  $prog \n"

      //!!" $prog   >> $ictout "
//!!" $prog   > xres.txt "

//     !!"nohup $prog  | tee --append $ictout "

       !!"$wasl -o ${prog}.xout -e ${prog}.xerr -t ${prog}.xtst -dx $prog   > foo-$prg"

  }

// what happens if prog crashes !!

  ntest++

  //<<"tail -3 $ictout > last_xic_test"
  //!!"tail -3 $ictout > last_xic_test"

//  <<"XIC ---"
//<<"%4d$(cbh++) $rt_tests $rt_pass "
\\FIX \\  !!"grep \"DONE:\" last_xic_test"
  //!!"grep $prog last_xic_test"


  fflush(1)
  }
  else {
//<<" NO xic $prog to test\n"
  }
}
//===============================


// FIX --- optional args -- have to be default activated -- to work for XIC?
// variable length args ??

proc cart_xic(str aprg, str a1,int  in_pargc)
{

//<<"%V xic vers  $aprg $a1 $in_pargc\n"

    if (fexist(aprg) != -1) {

       cart_arg = " $a1"
       a1arg = a1;

//<<"RUNNING XIC $cart_arg \n"

      tim = time() ;  //   TBC -- needs to reinstated
     
   // wt_prog = "$tim "

     xwt_prog = "$tim ./${aprg}: $cart_arg"

     //xwt_prog = "$(time())./${aprg}:$a1arg"

//<<"$xwt_prog \n"

  // <<"%V  $in_pargc > 1 ? \n"

   //in_pargc->info(1);

       a1="xx"
   if ( in_pargc > 1) {
      
<<"%V ./$aprg   $a1  $xwt_prog\n"

      doxictest("./$aprg", a1)
   }
   else {
   
//<<" no arg $in_pargc <= 1 \n"
      tim = time() ;  //   TBC -- needs to reinstated
      xwt_prog = "$tim ./${aprg}: "
      //xwt_prog = "$(time()) ./${aprg}: "

       doxictest("./$aprg"," ")
   }

      if (f_exist("${aprg}.xtst") > 0) {
         wlen = slen(xwt_prog)
         padit =nsc(40-wlen," ")
         <<"${xwt_prog}$padit"
	 <<[Opf]"${xwt_prog}$padit"

         scoreTest("${aprg}.xtst")
      }
     else {

       <<[Tcf]"#CRASH FAIL:--failed to run $aprg\n"
       
       CrashList->Insert("${Curr_dir}/xic_${aprg}")
     }

  }

  
} 
//================================//


proc cart (str aprg, str a1)
{
  int wlen;
  str tim;
  in_pargc = _pargc;
  
  xwt_prog = "xxx";
  cart_arg = ""
  a1arg = "";

   tim = time();

  if (_pargc >1) {
     cart_arg = " $a1"
     a1arg = a1;
  }

//<<"%V $_proc $aprg  $cart_arg <$a1arg> $tim \n"

  //ans=iread("?")

 
  !!"rm -f $aprg  ${aprg}.tst  last_test*"

//<<"asl -o ${aprg}.out -e ${aprg}.err -t ${aprg}.tst $CFLAGS ${aprg}.asl \n"
// !!"asl -o ${aprg}.out -e ${aprg}.err -t ${aprg}.tst $CFLAGS ${aprg}.asl "
//  !!" asl $CFLAGS ${aprg}.asl  | tee --append $tout "

   jpid  =0
   
// icompile(0)

  if (in_pargc > 1) {

// <<" asl $CFLAGS ${aprg}.asl  $a1 \n"
//  jpid = !!&"asl -o ${aprg}arg.out -e ${aprg}.err -t ${aprg}.tst  $CFLAGS ${aprg}.asl  $a1"


!!"$wasl -o ${aprg}.out -e ${aprg}.err -t ${aprg}.tst  $CFLAGS ${aprg}.asl  $a1  > foopar"

     wt_prog = "$(time()) ${aprg}:$a1arg "
     wlen = slen(wt_prog)
     padit =nsc(40-wlen," ")

     <<"${wt_prog}$padit"
      <<[Opf]"${wt_prog}$padit"

      if (f_exist("${aprg}.tst") > 0) {
          // should test if DONE
       //!!"grep DONE ${aprg}.tst"
           scoreTest("${aprg}.tst")
      }
     else {

       //<<"CRASH FAIL:--failed to run inseting $aprg into crashed list\n"
        CrashList->Insert("${Curr_dir}/${aprg}")
//	<<[Tcf]"${Curr_dir}/${aprg}\n"
     }

   }
   else {

//<<" asl $CFLAGS ${aprg}.asl  >> $tout & \n"
//    jpid = !!&"asl -o ${aprg}.out -e ${aprg}.err -t ${aprg}.tst $CFLAGS ${aprg}.asl"

      !!"$wasl -o ${aprg}.out -e ${aprg}.err -t ${aprg}.tst $CFLAGS ${aprg}.asl > foo   2>&1"

      if (f_exist("${aprg}.tst") > 0) {

         wt_prog = "$(time()) ${aprg}: "
         wlen = slen(wt_prog)
         padit =nsc(40-wlen," ")
         <<"${wt_prog}$padit"
         <<[Opf]"${wt_prog}$padit"	 

         scoreTest("${aprg}.tst")
      }
     else {

       //<<"CRASH FAIL:--failed to run \n"
       // insert works??
       CrashList->Insert("${Curr_dir}/${aprg}")

     }



//  !!" asl $CFLAGS ${aprg}.asl  > res_${aprg}.txt "
//    <<"%V$jpid \n"
   }

   w_file(Todo,"$(getdir())/${aprg}.asl $jpid $(time())\n")

//  <<"$(getdir())/${aprg}.asl $jpid $(time())\n"
 
    fflush(Todo)

// icompile(1)
//<<"$jpid \n"
//    snooze(15000)
// nanosleep(1,500)

    
  ntest++

    if (do_pause) {
        onward = iread("carryon? {no to quit}:)->");
	
	if (scmp(onward,"no")) {
          exit("quit ASL tests");
        }
    }


//!!"tail -3 $tout "
 // TBC if (do_xic)  // FAILS


  if (do_xic >0 ) {
    cart_xic(aprg,a1,in_pargc)
  }


  
}
//===============================




tout ="testoutput"
ictout ="ictestoutput"

//!!"echo ictest > $tout"
//!!"echo ictest > $ictout"


CFLAGS = "-cwl"

CFLAGS = "-cwlm"     // m to mask src lines in exe file

ntest = 0


int do_all = 1;
int do_tests = 0;
int do_array = 0;
int do_matrix = 0;
int do_bugs = 0;
int do_bops = 0;
int do_vops = 0;
int do_sops = 0;
int do_fops = 0;
int do_class = 0;
int do_declare = 0;
int do_include = 0;
int do_exp = 0;
int do_if = 0;
int do_logic = 0;
int do_for = 0;
int do_do = 0;
int do_paraex = 0;
int do_proc = 0;
int do_switch = 0;
int do_types = 0;
int do_func = 0;
int do_command = 0;
int do_lhsubsc = 0;
int do_dynv = 0;
int do_mops = 0;
int do_scope = 0;;
int do_oo = 0;
int do_sfunc = 0;
int do_svar = 0;
int do_record = 0;
int do_ivar = 0;
int do_lists = 0;
int do_stat = 0;
int do_threads = 0;
int do_while = 0;
int do_pan = 0;
int do_unary = 0;
int do_ptrs = 0;
int do_vmf = 0;
int do_help = 0;
int do_release = 0;



  pdir=updir()
  
  chdir("ITOC")
  Testdir = getdir()
<<"Test Dir is $Testdir\n"



 CrashList = ( "",  )  // empty list
 CrashList->LiDelete(0)
 FailedList = ( "",  )  // empty list --- bug first item null? 
 FailedList->LiDelete(0)
 



  nargs = ArgC()

  if (nargs > 1) {
    do_all = 0
   <<" selecting tests \n"
  }

  i = 1

    while (1) {


      wt = _argv[i]

     if (wt @= "bops") {
        do_bops = 1  
     }
   
     do_arg = "do_$wt"
     

    if (scmp(wt,"~",1) ){
        wt=scut (wt,1);
	<<"don't run $wt\n"
	do_arg = "do_$wt"
	$do_arg = -1
     }
      else {
      $do_arg = 1;
     }
//<<" $i $wt $do_arg \n"

     i++;

    if (i >= nargs)
          break;     

  }


  if (do_help) {

      help();
      exit();
  }

<<"%V $do_all $do_bops $do_mops \n"

// always
//  Run2Test("Bops")
//  cart("bops",7)
//================

<<"%V $do_all \n"

if (do_release) {
  wasl = "aslx"
  <<"testing release vers \n"
  !!"$wasl -v"
}



  if (runModule( do_bops)) {

    Run2Test("Bops")


// !!!! if basics fail warn/ask before going on to rest of testsuite

  cart("bops",7)
  
  cart("bops","")

  cart("fvmeq")

  cart("fvmeq",3)

  cart("fsc1")

  cart("mainvar")

  updir()

  changeDir("Contin")

  cart("contin")

  updir()

  changeDir("Mod")

  cart("mod")


  updir()


   }




    if (  runModule( do_types)) {
  
      RunDirTests("Types","float,str,char,long,short,double,pan_type,ato");
      
      RunDirTests("Cast","cast,cast_vec")

      RunDirTests("Efmt","efmt",);

      RunDirTests("Swab","swab")

  }


  if (runModule( do_vops)) {

     RunDirTests("Vops","vops,vopsele")

     RunDirTests("Vector","vec,veccat,vecopeq,vecrange,veclhrange")

   //     RunDirTests("Reverse","reverse") ; // BUG needs more than one
   Run2Test("Reverse")
   cart("reverse")

  }


//////////////////////////////////////////////////

  if (runModule( do_sops)) {
      //  need more str ops tests than this!

  RunDirTests("Sops","sops");

  // make this a pattern OP
  RunSFtests("Date,Sele,Sstr,Spat,Regex,Str,Split");

  Run2Test("Splice")
  cart("strsplice")

  }

/////////////////////////////////////////////////

  if (runModule( do_fops)) {

  Run2Test("Fexist")

  cart("fexist","fexist.asl")


  Run2Test("Fops")

  cart("readfile"," ")


  }


if ((do_all ==1) || (do_declare == 1) ) {

   Run2Test("Consts")

   cart ("consts_test")

   RunDirTests("Declare","declare,promote,declare_eq,chardeclare,scalar_dec,floatdeclare,arraydeclare,proc_arg_func");
  // RunDirTests("Declare","chardeclare,floatdeclare");

   Run2Test("Resize")

   cart ("resize")
   cart ("resize_vec")

   Run2Test("Redimn")

   cart ("redimn")



/////////////////////////////////////////////////////////////////////////////////

    }

<<" checkSwitch\n"
 if ( runModule (do_switch)) {
    <<"switch $do_all $do_switch \n"
    RunDirTests("Switch","switch,switch2")
 }

/////////////////////////////////////////////


<<" check Include\n"
if ( runModule (do_include) ) {

    Run2Test("Include")

   cart ("main_ni",2)
  


/////////////////////////////////////////////////////////////////////////////////

    }




changeDir(Testdir)

 if (runModule( do_exp )) {


   Run2Test("Sexp")

   cart("sexp", 10)



    }

////////////// IF ///////////////////////

if (runModule( do_if )) {

  Run2Test("If")

  cart("if0",10)

  RunDirTests("If","if,if4,md_assign,if5,if6,ifnest,if_fold")



  Run2Test("Bitwise")
  cart("bitwise")

  Run2Test("Define")
  cart("define")

  Run2Test("Enum")

  cart("colors_enum")


////////////////////////////////////////////////////////////////////////

    }

  if (runModule( do_logic )) {

   RunDirTests("Logic","logic,logic2,logic_def")

  }

 if (runModule( do_for )) {

   RunDirTests("For","for,for0,forexp")
}


////////////////////////////////////////////////////////////////////////
 

  if (runModule( do_while )) {

  Run2Test("While")
  cart("while")
  cart("while0", 10)
  cart("while1")


    }
////////////////////////////////////////////////////////////////////////






if (runModule( do_do )) {

   Run2Test("Do")

   cart("do0", 5)

   cart("do1", 6)



////////////////////////////////////////////////////////////////////////
    }


 if (runModule( do_paraex )) {

  Run2Test("ParaEx")

  cart("paraex")



 }


/////////////// ARRAY //////////////////////

if (runModule( do_array )) {

   RunDirTests("Array","ae,arraystore,arrayele,arrayele0,arrayele1,arraysubset")
   RunDirTests("Array","arrayrange,arraysubvec,arraysubsref,arraysubsrange,arraysubscbyvec")
   RunDirTests("Array","dynarray,lhrange,lhe,joinarray,vec_cat,vgen,array_sr,mdele,vsp,arrayindex")

  RunDirTests("Scalarvec","scalarvec")

  RunDirTests("Subrange","subrange,subrange2");
  
  Run2Test("PrePostOp")

  cart("prepost_opr")

  RunDirTests("M3D","m3d,m3d_assign")

  Run2Test("Sgen")

  cart("sgen")

  Run2Test("VVgen")

  cart("vvgen")

  Run2Test("VVcopy")

  cart("vvcopy")

  Run2Test("VVcomp")

  cart("vvcomp")

  Run2Test("Vfill")

  cart("vfill")

    }


/////////////////////////////////////////

 if (runModule( do_matrix )) {
 
   Run2Test("Mdimn")

   cart("mdimn0")



   RunDirTests("Matrix","mat_mul,msquare,mdiag");
   

   Run2Test("Msort")
   cart("msort")


   }


/////////////////////////////////////////

 if (runModule( do_dynv )) {

    hdg("DYNAMIC_V")

    RunDirTests("Dynv","dynv,dynv2");


    }

/////////////////////////////////////////

if (runModule( do_lhsubsc )) {

  Run2Test("Subscript")

  cart("lharraysubsrange")

    }

/////////////////////////////////////////

if (runModule( do_func )) {

  Run2Test("Func")
  cart("func", 3,4)

  RunDirTests("Func","func0,func1,funcargs")


  Run2Test("Ifunc")

   cart ("iproc")

}

/////////////////////////////////////////

if (runModule( do_unary )) {


  Run2Test("Unary")

  cart("unaryexp")


}

/////////////////////////////////////////

   if (runModule( do_command )) {

     RunDirTests("Command","command,command_parse")

    }


/////////////////////////////////////////
if (runModule( do_proc )) {

  RunDirTests("Proc","proc,proc_declare,procret0,procarg,proc_sv0,proc_rep")
  RunDirTests("Proc","proc_str_ret,procrefarg,proc_ra,procrefstrarg,proc-loc-main-var");

  cart("proc_var_define", 10)

  Run2Test("ProcArray")
  
  hdg("ProcArray");  

  cart("arrayarg1")
  
  cart("arrayarg2")


  RunDirTests("Swap","swap1","swap")

  Run2Test("Static")
  
  hdg("Static") ; 

  cart("static");

  
  }


  if (runModule( do_scope )) {

   Run2Test("Scope") ; 

   cart("scope");

  }

if (runModule( do_mops )) {

    RunDirTests("Mops","mops")



    hdg("RECURSION")

    Run2Test("Fact")

    cart("fact", 10)

    Run2Test("Cmplx")

    cart("cmplx")
    
    Run2Test("Rand")

    cart("rand")


    }



   if (runModule( do_svar )) {

    Run2Test("Svar")
    cart("svar1", "string operations are not always easy" )
    RunDirTests("Svar","svar");
    Run2Test("Hash")
    cart("svar_table")
    cart("svar_hash")    
    }

  if (runModule( do_ivar )) {

     Run2Test("Ivar")

     cart("ivar")

    }


  if (runModule( do_record )) {

    RunDirTests("Record","rec1,record,readrecord,prtrecord,recprt,recatof,reclhs,rectest,mdrecord,rrdyn");


  }

 changeDir(Testdir)

 if (runModule( do_mops )) {
 
    Run2Test("Math")

    cart ("inewton")
    cart ("inewton_cbrt")
    cart ("opxeq")

    Run2Test("Prime")

    //    cart ("prime_65119")
    cart ("prime_127")


    Run2Test("Pow")

    cart("pow")

    }


 changeDir(Testdir)

 if (runModule( do_stat )) {

    hdg("STAT")

    Run2Test("Polynom")
    cart("checkvm")
    cart("polyn")



}

 if (runModule( do_pan )) {

    hdg("PAN")

    RunDirTests("Pan","pan,pan-loop-test,pancmp,panarray")

    cart("derange",100)


}


   if (runModule( do_lists )) {

     RunDirTests("Lists","list,list_declare,listele,list_ins_del");

    }

   if (runModule( do_ptrs )) {

     RunDirTests("Ptrs","ptrvec,ptr-numvec,ptr-svarvec,ptr_varvec,indirect");

   }

   if (runModule( do_class )) {

       RunDirTests("Class","class_mfcall,classbops,class2,classvar");

    }



   if (runModule( do_oo )) {

    RunDirTests("OO","rpS,rp2,wintersect,oa,oa2,sh,class_array");

    Run2Test("Obcopy")

  cart("obcopy")
  cart("obprocarg")

    //  cart("objivar")

  Run2Test("Mih")

  cart("mih")

  }


 if (runModule( do_sfunc )) {

    hdg("S-FUNCTIONS")

    RunSFtests("Sscan,Fscanf,Bscan,Cut,Cmp,Sel,Shift,Median,Findval,Lip");

//============================
    RunSFtests("BubbleSort,Typeof,Variables,Trig,Caz,Sizeof,Limit,D2R,Cbrt,Fabs");
    RunSFtests("Round,Trunc,Wdata,Fscanv,Cmpsetv,Vrange,MDRange");
//============================

    RunDirTests("Funcs","abs");


/// chem    -- find an atomic number for an element

    Run2Test("Chem")
    cart("chem0")

    RunDirTests("Packb","packb,packalot");
    
//============================    

    }


if (runModule( do_vmf)) {

    RunDirTests("Vmf","vmf")

  }



//////////////////// BUGFIXs/////////////////////////////////////////

  if (runModule( do_bugs )) {
      //cart("bf_40")   // this has intentional error and exits before test checks
    changeDir(Testdir)

     chdir("BUGFIX")
<<"Doing bug tests"
!!"pwd"

BFS=!!"ls bf*.asl "
<<"$(typeof(BFS)) $BFS\n"
bflist="$BFS"

   bug_list = ssub(bflist,".asl"," ,",0)
   
<<"$bug_list\n"

      RunDirTests("BUGFIX",bug_list)
    
  }


  if (runModule( do_tests )) {
    changeDir(Testdir)
//  get a list of asl files in this dir and run them
     chdir("Tests")
<<"Doing Tests"
!!"pwd"

TS=!!"ls *.asl "
<<"$(typeof(TS)) $TS\n"
tslist="$TS"
//<<"$(typeof(tslist)) $tslist\n"
   test_list = ssub(tslist,".asl",",",0)
   
<<"%V $test_list\n"
     RunDirTests("Tests",test_list);
    
  }

/{
if (runModule( do_threads )) {
        Run2Test("Threads")
        cart("threads")
    
}
/}
  ///////////////////////////////////////////////////////////////////////////////////////////


// and the Grand Total is ???

   pcc = rt_pass/(1.0*rt_tests) * 100

   flsz = caz(FailedList)
   

    fseek(Tlogf,0,2)



  if (flsz >= 1) {

<<"\n$flsz modules  failed! \n"
<<[Opf]"\n$flsz modules  failed! \n"
<<[Tlogf]"\n$flsz modules  failed! \n"

   FailedList->Sort()

//<<" %(2,\t, ,\n)$FailedList \n"  // would like this to work like for vectors ---

   for (i = 0; i < flsz ; i++) {
       <<"$FailedList[i] \n"

       <<[Opf]"$FailedList[i] \n"

      <<[Tff]"$FailedList[i] \n"
       
       <<[Tlogf]"$i $FailedList[i] \n"       
    }
}
<<"----------------------------------------------------------------------------\n"

  
   lsz = caz(CrashList)
//<<"failed list size $flsz crash $lsz \n"
//   flsz->info(1)
//   lsz->info(1)
   

if (lsz >= 1) {

<<"\n$lsz modules   crashed! \n"
<<[Opf]"\n$lsz modules   crashed! \n"
<<[Tlogf]"\n$lsz modules   crashed! \n"

   CrashList->Sort()

<<" crashlist $lsz   \n"
   for (i = 0; i < lsz ; i++) {
   <<"$i $CrashList[i] \n"
   <<[Opf]"$CrashList[i] \n"
   <<[Tcf]"$CrashList[i] \n"
   <<[Tlogf]"$i $CrashList[i] \n"
//   if (i > clsz)       break;
   }
   
}


<<"----------------------------------------------------------------------------\n"
<<"$(date(1)) Modules $n_modules Tests $rt_tests  Passed $rt_pass  Score %6.2f$pcc Fail %d$flsz Crash $lsz vers $(get_version())\n"

<<[Opf]"$(date(1)) Modules $n_modules Tests $rt_tests  Passed $rt_pass  Score %6.2f$pcc Fail %d$flsz Crash $lsz $(get_version())\n"
<<[Tlogf]"$(date(1)) Modules $n_modules Tests $rt_tests  Passed $rt_pass  Score %6.2f$pcc Fail %d$flsz Crash $lsz $(get_version())\n"    

fflush(Opf)
cf(Opf)

fflush(Tcf)
cf(Tcf)

fflush(Tff)
cf(Tff);
fflush(Tlogf)
cf(Tlogf);
changeDir(cwd)

//!!"pwd"

//<<"cp Scores/score_$(date(2,'-')) current_score \n"



//!!"cp Scores/score_$(date(2,'-')) current_score"
!!"cp current_score Scores/score_$(date(2,'-')) "

dtms= FineTimeSince(TM);
secs = dtms/1000000.0


<<"script vers $_ele_vers took %6.3f$secs secs %d %V $i_time $x_time\n"
today=getDate(1);
<<"used $wasl for tests \n"
!!"$wasl -v"
<<"$today tested $(get_version())\n"
sipause(1)
if (pcc < 100.0) {
<<"$pcc fixes needed!! \n"
}
else {
<<"$pcc Success Hooray! \n"
}
exit(0)


//// TBD///
/{/*

how to not do test item

/}*/


